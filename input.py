import face_recognition
import mysql.connector
import argparse
import numpy as np
import json

def face_distance(face_encodings, face_to_compare):
    if len(face_encodings) == 0:
        return np.empty((0))
    return np.linalg.norm(face_encodings - face_to_compare, axis=1)
def compare_faces(known_face_encodings, face_encoding_to_check):
    a = face_distance(known_face_encodings, face_encoding_to_check)
    return np.argmin(a) #get the min index
def get_match(match):
    indexs = []
    for i in range(len(match)):
        if match[i] == True:
            indexs.append(i)
    return indexs
def get_data(records,indexs):
    data = []
    for index in indexs:
        tmp = [records[index][2],records[index][3],records[index][4]]
        data.append(tmp)
    return data
def find_database(face_encoding):
    mydb = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = '',
        database = 'facedb'
    )
    mycursor = mydb.cursor()
    sql = "select * from faces"
    mycursor.execute(sql)
    records = mycursor.fetchall()
    known_face_encodings = []
    for row in records:
        tmp = row[1].split(',')
        for i in range(len(tmp)):
            tmp[i] = float(tmp[i])
        arr = np.array(tmp)
        known_face_encodings.append(arr) #feature
    match = face_recognition.compare_faces(known_face_encodings,face_encoding,tolerance = 0.45)
    indexs = get_match(match)
    data = get_data(records,indexs)
    #data = [records[match][2],records[match][3],records[match][4]]
    return data

def encode(opt):
    file_name = opt.image
    image = face_recognition.load_image_file(file_name)
    face_encoding = face_recognition.face_encodings(image)[0]
    return face_encoding
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--image', type=str, default='test.PNG', help='image')
    opt = parser.parse_args()
    face_encoding = encode(opt)
    data = find_database(face_encoding)
    print(json.dumps(data))
    #return data