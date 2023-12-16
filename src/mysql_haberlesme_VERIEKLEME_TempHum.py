import mysql.connector
import serial
import time

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Adocu123!",
    auth_plugin='mysql_native_password',
    database="smarthomev2"
)

mycursor = mydb.cursor()

arduino = serial.Serial("COM4", baudrate=960,)
satir_limit = 6
satir = 0


while True:
    data = arduino.readline().decode('utf-8').strip().split("\t")
    if len(data) == 2:
        humidity, temperature = map(float, data)
        simdi = time.strftime("%H:%M:%S")
        print(f"Saat {simdi}: Sıcaklık={temperature} Nem={humidity}")

        sql = "INSERT INTO temp_hum (Temperature, Humidity) VALUES (%s, %s)"
        val = (temperature, humidity)
        mycursor.execute(sql, val)

        mydb.commit()  # Değişiklikleri veritabanına kaydet

       

        if satir >= satir_limit:
            # Belirli bir satır limitine ulaşıldığında verileri sil
            delete_sql = "DELETE FROM temp_hum"
            mycursor.execute(delete_sql)
            mydb.commit()

            satir = 0  # Satır sayısını sıfırla
        else:
            satir += 1


    time.sleep(10)
