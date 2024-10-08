# limit the number of cpus used by high performance libraries
import os
os.environ["OMP_NUM_THREADS"] = "1"
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["MKL_NUM_THREADS"] = "1"
os.environ["VECLIB_MAXIMUM_THREADS"] = "1"
os.environ["NUMEXPR_NUM_THREADS"] = "1"

import sys
sys.path.insert(0, './yolov5')

from yolov5.models.experimental import attempt_load
from yolov5.utils.downloads import attempt_download
from yolov5.models.common import DetectMultiBackend
from yolov5.utils.datasets import LoadImages, LoadStreams
from yolov5.utils.general import LOGGER, check_img_size, non_max_suppression, scale_coords, check_imshow, xyxy2xywh
from yolov5.utils.torch_utils import select_device, time_sync
from yolov5.utils.plots import Annotator, colors
from deep_sort_pytorch.utils.parser import get_config
from deep_sort_pytorch.deep_sort import DeepSort
import argparse
import os
import platform
import shutil
import time
from pathlib import Path
import cv2
import torch
import torch.backends.cudnn as cudnn

###new
import face_recognition
import mysql.connector
import numpy as np

def face_distance(face_encodings, face_to_compare):
    if len(face_encodings) == 0:
        return np.empty((0))
    return np.linalg.norm(face_encodings - face_to_compare, axis=1)
def compare_faces(known_face_encodings, face_encoding_to_check, tolerance):
    a = face_distance(known_face_encodings, face_encoding_to_check)
    if np.amin(a) <= tolerance: # if same face in faces_merge database
        return np.argmin(a) #get the min index
    return False # didn't find
        
def get_data(records,indexs):
    data = []
    for index in indexs:
        tmp = [records[index][2],records[index][3],records[index][4]]
        data.append(tmp)
    return data
def merge_data(mydb,mycursor,records,index,face_encoding):
    origin_feature = records[index][1].split(',')
    count = records[index][2]
    for i in range(len(origin_feature)):
        origin_feature[i] = float(origin_feature[i])
        arr = np.array(origin_feature)
    merge_feature = (arr * count + face_encoding) / (count + 1)
    feature = face_encoding_to_feature(merge_feature)
    sql = "update faces_merged set features = \'" + feature + "\' where id = " + str(index)
    mycursor.execute(sql)
    sql = "update faces_merged set count = \'" + str(count + 1) + "\' where id = " + str(index)
    mycursor.execute(sql)
    mydb.commit()
def face_encoding_to_feature(face_encoding):
    feature = np.array2string(face_encoding, formatter={'float_kind':lambda x: "%.18f" % x}).replace('\n','').replace(' ',',')
    feature = feature[1:]
    feature = feature[:-1]
    return feature
def store_to_merge_database(mydb,mycursor,face_encoding):
    mycursor.execute('SELECT MAX(id) FROM faces_merged;')
    max = mycursor.fetchall()
    max = max[0][0]
    if max == None: #if no data
        max = -1
    sql = "insert into faces_merged (id, features, count) values (%s, %s, %s)"
    feature = face_encoding_to_feature(face_encoding)
    index = max + 1
    count = 1
    val = (index,feature,count,)
    mycursor.execute(sql, val)
    print(mycursor.rowcount, "record inserted.")
    mydb.commit()
    return index
def check_merge(mydb,mycursor,face_encoding):
    sql = "select * from faces_merged"
    mycursor.execute(sql)
    records = mycursor.fetchall()
    mydb.commit()
    known_face_encodings = []
    for row in records:
        tmp = row[1].split(',')
        for i in range(len(tmp)):
            tmp[i] = float(tmp[i])
        arr = np.array(tmp)
        known_face_encodings.append(arr) #feature
    if known_face_encodings:
        index = compare_faces(known_face_encodings,face_encoding,tolerance = 0.4) # the min distance in faces_merged
        if index != False: # have same face in database
            merge_data(mydb,mycursor,records,index,face_encoding)
            return index
    index = store_to_merge_database(mydb,mycursor,face_encoding)
    return index

def store_to_database(average_encoded_dict,id_time,source):
    mydb = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = '',
        database = 'facedb'
    )
    
    mycursor = mydb.cursor()
    mycursor.execute('SELECT MAX(id) FROM faces;')
    max = mycursor.fetchall()
    max = max[0][0] #get the max id
    if max == None: #if no data
        max = 0

    #新增資料
    sql = "insert into faces (id, features, start_time, end_time, device, merged_id) values (%s, %s, %s, %s, %s, %s)"
    vals = []


    for key,value in average_encoded_dict.items():
        feature = np.array2string(value, formatter={'float_kind':lambda x: "%.18f" % x}).replace('\n','').replace(' ',',')
        feature = feature[1:]
        feature = feature[:-1]
        check = check_merge(mydb,mycursor,value)
        val = (max + int(key),feature,id_time[key][0],id_time[key][1],source,int(check))
        vals.append(val)
    mycursor.executemany(sql, vals)
    print(mycursor.rowcount, "record inserted.")

    mydb.commit()

def detect(opt):
    out, source, yolo_weights, deep_sort_weights, show_vid, save_vid, save_txt, imgsz, evaluate, half = \
        opt.output, opt.source, opt.yolo_weights, opt.deep_sort_weights, opt.show_vid, opt.save_vid, \
            opt.save_txt, opt.imgsz, opt.evaluate, opt.half
    webcam = source == '0' or source.startswith(
        'rtsp') or source.startswith('http') or source.endswith('.txt')

    print(save_vid)

    # initialize deepsort
    cfg = get_config()
    cfg.merge_from_file(opt.config_deepsort)
    attempt_download(deep_sort_weights, repo='mikel-brostrom/Yolov5_DeepSort_Pytorch')
    deepsort = DeepSort(cfg.DEEPSORT.REID_CKPT,
                        max_dist=cfg.DEEPSORT.MAX_DIST, min_confidence=cfg.DEEPSORT.MIN_CONFIDENCE,
                        max_iou_distance=cfg.DEEPSORT.MAX_IOU_DISTANCE,
                        max_age=cfg.DEEPSORT.MAX_AGE, n_init=cfg.DEEPSORT.N_INIT, nn_budget=cfg.DEEPSORT.NN_BUDGET,
                        use_cuda=True)

    # Initialize
    device = select_device(opt.device)
    half &= device.type != 'cpu'  # half precision only supported on CUDA

    # The MOT16 evaluation runs multiple inference streams in parallel, each one writing to
    # its own .txt file. Hence, in that case, the output folder is not restored
    if not evaluate:
        if os.path.exists(out):
            pass
            shutil.rmtree(out)  # delete output folder
        os.makedirs(out)  # make new output folder

    # Load model
    device = select_device(device)
    model = DetectMultiBackend(opt.yolo_weights, device=device, dnn=opt.dnn)
    stride, names, pt, jit, onnx = model.stride, model.names, model.pt, model.jit, model.onnx
    imgsz = check_img_size(imgsz, s=stride)  # check image size

    # Half
    half &= pt and device.type != 'cpu'  # half precision only supported by PyTorch on CUDA
    if pt:
        model.model.half() if half else model.model.float()

    # Set Dataloader
    vid_path, vid_writer = None, None
    # Check if environment supports image displays
    if show_vid:
        show_vid = check_imshow()

    # Dataloader
    if webcam:
        view_img = check_imshow()
        cudnn.benchmark = True  # set True to speed up constant image size inference
        dataset = LoadStreams(source, img_size=imgsz, stride=stride, auto=pt and not jit)
        bs = len(dataset)  # batch_size
    else:
        dataset = LoadImages(source, img_size=imgsz, stride=stride, auto=pt and not jit)
        bs = 1  # batch_size
    vid_path, vid_writer = [None] * bs, [None] * bs

    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names

    save_path = str(Path(out))
    # extract what is in between the last '/' and last '.'
    txt_file_name = source.split('/')[-1].split('.')[0]
    txt_path = str(Path(out)) + '/' + txt_file_name + '.txt'

    if pt and device.type != 'cpu':
        model(torch.zeros(1, 3, *imgsz).to(device).type_as(next(model.model.parameters())))  # warmup
    dt, seen = [0.0, 0.0, 0.0], 0

    #python track2.py --source walk.mp4  --yolo_weights yolov5/weights/crowdhuman_yolov5m.pt --classes 0
    encoded_faces = {}
    id_time = {}
    for frame_idx, (path, img, im0s, vid_cap, s) in enumerate(dataset):
        seconds = frame_idx / vid_cap.get(cv2.CAP_PROP_FPS)
        # if frame_idx > 262:
        #     break
        t1 = time_sync()
        img = torch.from_numpy(img).to(device)
        img = img.half() if half else img.float()  # uint8 to fp16/32
        img /= 255.0  # 0 - 255 to 0.0 - 1.0
        if img.ndimension() == 3:
            img = img.unsqueeze(0)
        t2 = time_sync()
        dt[0] += t2 - t1

        # Inference
        visualize = increment_path(save_dir / Path(path).stem, mkdir=True) if opt.visualize else False
        pred = model(img, augment=opt.augment, visualize=visualize)
        t3 = time_sync()
        dt[1] += t3 - t2

        # Apply NMS
        pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, opt.classes, opt.agnostic_nms, max_det=opt.max_det)
        dt[2] += time_sync() - t3

        # Process detections
        for i, det in enumerate(pred):  # detections per image
            seen += 1
            if webcam:  # batch_size >= 1
                p, im0, frame = path[i], im0s[i].copy(), dataset.count
                s += f'{i}: '
            else:
                p, im0, frame = path, im0s.copy(), getattr(dataset, 'frame', 0)

            s += '%gx%g ' % img.shape[2:]  # print string
            save_path = str(Path(out) / Path(p).name)

            annotator = Annotator(im0, line_width=2, pil=not ascii)

            if det is not None and len(det):
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(
                    img.shape[2:], det[:, :4], im0.shape).round()

                # Print results
                for c in det[:, -1].unique():
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string

                xywhs = xyxy2xywh(det[:, 0:4])
                confs = det[:, 4]
                clss = det[:, 5]

                # pass detections to deepsort
                outputs = deepsort.update(xywhs.cpu(), confs.cpu(), clss.cpu(), im0)
                
                # draw boxes for visualization
                if len(outputs) > 0:
                    ##recognize##
                    face_locations = face_recognition.face_locations(im0,model="cnn")
                    face_encodings = face_recognition.face_encodings(im0, face_locations)
                    ##recognize##
                    for j, (output, conf) in enumerate(zip(outputs, confs)): 
                        bboxes = output[0:4] #left up right down
                        id = output[4]

                        ##add new dict key##
                        if id not in encoded_faces:
                            encoded_faces[id] = []
                            id_time[id] = [seconds,0] #start_time,end_time
                        else:
                            id_time[id][1] = seconds
                        ##add new dict key##

                        ##add value to key##
                        i = 0
                        for top, right, bottom, left in face_locations:
                            if(left > bboxes[0] and top > bboxes[1] and right < bboxes[2] and bottom < bboxes[3]):
                                encoded_faces[id].append(face_encodings[i])
                            i += 1
                        ##add value to key##

                        cls = output[5]
                        c = int(cls)  # integer class
                        label = f'{id} {names[c]} {conf:.2f}'
                        annotator.box_label(bboxes, label, color=colors(c, True))

                        # if save_txt:
                        #     # to MOT format
                        #     bbox_left = output[0]
                        #     bbox_top = output[1]
                        #     bbox_w = output[2] - output[0]
                        #     bbox_h = output[3] - output[1]
                        #     # Write MOT compliant results to file
                        #     with open(txt_path, 'a') as f:
                        #        f.write(('%g ' * 10 + '\n') % (frame_idx + 1, id, bbox_left,
                        #                                    bbox_top, bbox_w, bbox_h, -1, -1, -1, -1))  # label format
            else:
                deepsort.increment_ages()

            # Print time (inference-only)
            LOGGER.info(f'{s}Done. ({t3 - t2:.3f}s)')

            # Stream results
            im0 = annotator.result()
            if show_vid:
                cv2.imshow(p, im0)
                if cv2.waitKey(1) == ord('q'):  # q to quit
                    raise StopIteration

            # Save results (image with detections)
            if save_vid:
                if vid_path != save_path:  # new video
                    vid_path = save_path
                    if isinstance(vid_writer, cv2.VideoWriter):
                        vid_writer.release()  # release previous video writer
                    if vid_cap:  # video
                        fps = vid_cap.get(cv2.CAP_PROP_FPS)
                        w = int(vid_cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                        h = int(vid_cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                    else:  # stream
                        fps, w, h = 30, im0.shape[1], im0.shape[0]
                        save_path += '.mp4'

                    vid_writer = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))
                vid_writer.write(im0)
    ##get average_dict
    average_encoded_dict = {}
    for key,value in encoded_faces.items():
        average_encoded_dict[key] = []
        average_encoded_dict[key] = sum(value) / len(value)
    
    store_to_database(average_encoded_dict,id_time,source)
    

    # # Print results
    # t = tuple(x / seen * 1E3 for x in dt)  # speeds per image
    # LOGGER.info(f'Speed: %.1fms pre-process, %.1fms inference, %.1fms NMS per image at shape {(1, 3, *imgsz)}' % t)
    # if save_txt or save_vid:
    #     s = f"\n{len(list(save_dir.glob('labels/*.txt')))} labels saved to {save_dir / 'labels'}" if save_txt else ''
    #     LOGGER.info(f"Results saved to {colorstr('bold', save_dir)}{s}")
    #     if platform == 'darwin':  # MacOS
    #         os.system('open ' + save_path)




if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--yolo_weights', nargs='+', type=str, default='yolov5l.pt', help='model.pt path(s)')
    parser.add_argument('--deep_sort_weights', type=str, default='deep_sort_pytorch/deep_sort/deep/checkpoint/ckpt.t7', help='ckpt.t7 path')
    # file/folder, 0 for webcam
    parser.add_argument('--source', type=str, default='0', help='source')
    parser.add_argument('--output', type=str, default='inference/output', help='output folder')  # output folder
    parser.add_argument('--imgsz', '--img', '--img-size', nargs='+', type=int, default=[640], help='inference size h,w')
    parser.add_argument('--conf-thres', type=float, default=0.4, help='object confidence threshold')
    parser.add_argument('--iou-thres', type=float, default=0.5, help='IOU threshold for NMS')
    parser.add_argument('--fourcc', type=str, default='mp4v', help='output video codec (verify ffmpeg support)')
    parser.add_argument('--device', default='', help='cuda device, i.e. 0 or 0,1,2,3 or cpu')
    parser.add_argument('--show-vid', action='store_true', help='display tracking video results')
    parser.add_argument('--save-vid', action='store_true', help='save video tracking results')
    parser.add_argument('--save-txt', action='store_true', help='save MOT compliant results to *.txt')
    # class 0 is person, 1 is bycicle, 2 is car... 79 is oven
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 16 17')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')
    parser.add_argument('--evaluate', action='store_true', help='augmented inference')
    parser.add_argument("--config_deepsort", type=str, default="deep_sort_pytorch/configs/deep_sort.yaml")
    parser.add_argument("--half", action="store_true", help="use FP16 half-precision inference")
    parser.add_argument('--visualize', action='store_true', help='visualize features')
    parser.add_argument('--max-det', type=int, default=1000, help='maximum detection per image')
    parser.add_argument('--dnn', action='store_true', help='use OpenCV DNN for ONNX inference')
    opt = parser.parse_args()
    opt.imgsz *= 2 if len(opt.imgsz) == 1 else 1  # expand

    with torch.no_grad():
        detect(opt)
