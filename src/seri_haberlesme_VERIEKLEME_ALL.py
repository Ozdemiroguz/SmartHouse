import serial
import time
import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Adocu123!",
    auth_plugin='mysql_native_password',
    database="smarthomev2"
)

mycursor = mydb.cursor()

arduino_port = "COM4"
arduino = serial.Serial(arduino_port, baudrate=9600)

satir = 0

while True:
    data = arduino.readline().decode('utf-8').strip().split(",")

    if len(data) == 5:
        humidity, temperature, gas, flame, motion = map(float, data)

        # Hareket sensörü verisini bool olarak tanımla
        motion_bool = bool(motion)

        # Yangın sensörü verisini bool olarak tanımla
        flame_bool = bool(flame)

        simdi = time.strftime("%H:%M:%S")
        print(f"Saat {simdi}: Sıcaklık={temperature} Nem={humidity} Hareket={motion_bool} Yangın={flame_bool} Gaz={gas}")

        # sql = "INSERT INTO temp_hum (Temperature, Humidity) VALUES (%s, %s)"
        # val = (temperature, humidity)
        # mycursor.execute(sql, val)
        # mydb.commit()  # Değişiklikleri veritabanına kaydet

        sql2 = "INSERT INTO gas (Gas) VALUES (%s)"
        val2 = (gas,)
        mycursor.execute(sql2, val2)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

        sql3 = "INSERT INTO fire (Fire) VALUES (%s)"
        val3 = (flame_bool,)
        mycursor.execute(sql3, val3)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

        sql4 = "INSERT INTO motion (Motion) VALUES (%s)"
        val4 = (motion_bool,)
        mycursor.execute(sql4, val4)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

        if simdi == "00:00:00":
            # gün sıfırlandığında (ertesi gün) verileri sil
            delete_sql = "DELETE FROM temp_hum"
            mycursor.execute(delete_sql)
            delete_sql2 = "DELETE FROM gas"
            mycursor.execute(delete_sql2)
            delete_sql3 = "DELETE FROM fire"
            mycursor.execute(delete_sql3)
            delete_sql4 = "DELETE FROM motion"
            mycursor.execute(delete_sql4)

            mydb.commit()

            satir = 0  # Satır sayısını sıfırla
        else:
            satir += 1

    #60 saniyede bir (satır 6 nın katı olduğunda ) temp_hum tablosuna  veri ekle
    if satir % 6 == 0:
        sql = "INSERT INTO temp_hum (Temperature, Humidity) VALUES (%s, %s)"
        val = (temperature, humidity)
        mycursor.execute(sql, val)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

      

    time.sleep(10)



   