import face_recognition
import mysql.connector
import argparse
import numpy as np

def store_to_database(face_encoding):
    mydb = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = '',
        database = 'facedb'
    )
    mycursor = mydb.cursor()
    sql = "insert into input (features) values (%s)"
    feature = np.array2string(face_encoding, formatter={'float_kind':lambda x: "%.18f" % x}).replace('\n','').replace(' ',',')
    val = (feature,)
    mycursor.execute(sql, val)
    print(mycursor.rowcount, "record inserted.")
    mydb.commit()

def encode(opt):
    file_name = opt.image
    image = face_recognition.load_image_file(file_name)
    face_encoding = face_recognition.face_encodings(image)[0]

    store_to_database(face_encoding)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--image', type=str, default='test.PNG', help='image')
    opt = parser.parse_args()
    encode(opt)