import serial
import time
import mysql.connector
from datetime import datetime

mydb = mysql.connector.connect(
    host="mysql6008.site4now.net",
    user="aa363f_shome",
    password="Adocu123!",
    auth_plugin='mysql_native_password',
    database="db_aa363f_shome"
)



mycursor = mydb.cursor()

print("Database bağlantısı kuruldu...")




# Yeniden başlatıldığında user ve room verilerini silme
mycursor.execute('DELETE FROM user')
mycursor.execute('DELETE FROM room')
mydb.commit()

time.sleep(3)


print("Cihaz bağlantısı kuruluyor...")
time.sleep(3)




arduino_port = "COM4"
arduino = serial.Serial(arduino_port, baudrate=9600)

print("Cihaz bağlantısı kuruldu...")
time.sleep(3)


# Cihazı başlatma
print ("Cihaz başlatılıyor...")
time.sleep(3)



# kullanıcı tanımlama
UserID=1
UserEmail="ademmavanaci@gmail.com" # admin mail adresi
UserName="admin"
UserSurname="admin" 
UserPassword="Adocu123!" # admin şifresi
UserPhone="5534164182" # admin telefon numarası
NumberOfRooms=3 # adminin sahip olduğu oda sayısı

Active=1



# Odaları tanımlama
RoomID=1
RoomName="Ana Salon"
OptimumTemp=25
OptimumHum=50
OptimumGas=50
RoomType="Salon"



sql= "INSERT INTO user (UserID, Mail, Name, Surname, Password, Phone, NumberOfRooms, Active) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
val=(UserID, UserEmail, UserName, UserSurname, UserPassword, UserPhone, NumberOfRooms, Active)
mycursor.execute(sql, val)
mydb.commit() # Değişiklikleri veritabanına kaydet


sql2= "INSERT INTO room (RoomID, UserID, RoomName, OptimumTemperature, OptimumHumidity, OptimumGase, RoomType) VALUES (%s, %s, %s, %s, %s, %s, %s)"
val2=(RoomID,UserID, RoomName, OptimumTemp, OptimumHum, OptimumGas, RoomType)
mycursor.execute(sql2, val2)
mydb.commit() # Değişiklikleri veritabanına kaydet





satir = 0

while True:
    data = arduino.readline().decode('utf-8').strip().split(",")

    if len(data) == 5:
        humidity, temperature, gas, flame, motion = map(float, data)

        # Hareket sensörü verisini bool olarak tanımla
        motion_bool = bool(motion)

        # Yangın sensörü verisini bool olarak tanımla
        flame_bool = bool(flame)




        # Verileri ekrana yazdırma
        simdi = time.strftime("%H:%M:%S")
        print(f"Saat {simdi}: Sıcaklık={temperature} Nem={humidity} Hareket={motion_bool} Yangın={flame_bool} Gaz={gas}")

        
        

        # Verileri veritabanına ekleme



        sql3 = "INSERT INTO gas (RoomID, Gas) VALUES (%s,%s)"
        val3 = (RoomID,gas)
        mycursor.execute(sql3, val3)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

        sql4 = "INSERT INTO fire (RoomID, Fire) VALUES (%s,%s)"
        val4 = (RoomID,flame_bool)
        mycursor.execute(sql4, val4)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

        sql5 = "INSERT INTO move (RoomID, Move) VALUES (%s,%s)"
        val5 = (RoomID,motion_bool)
        mycursor.execute(sql5, val5)
        mydb.commit()  # Değişiklikleri veritabanına kaydet
        
       

        bugun = datetime.now()
        
        if bugun.weekday() == 0 and simdi == "00:00:00":  # Pazartesi ve saat 00:00:00 kontrolü
            # gün sıfırlandığında (ertesi gün) verileri sil
            delete_sql6 = "DELETE FROM temp_hum"
            mycursor.execute(delete_sql6)
            delete_sql3 = "DELETE FROM gas"
            mycursor.execute(delete_sql3)
            delete_sql4 = "DELETE FROM fire"
            mycursor.execute(delete_sql4)
            delete_sql5 = "DELETE FROM move"
            mycursor.execute(delete_sql5)

            mydb.commit()

            satir = 0  # Satır sayısını sıfırla
        else:
            satir += 1

    #60 saniyede bir (satır 6 nın katı olduğunda ) temp_hum tablosuna  veri ekle
    if satir % 6 == 0:
        sql6 = "INSERT INTO temp_hum (RoomID,Temperature, Humidity) VALUES (%s, %s,%s)"
        val6 = (RoomID,temperature, humidity)
        mycursor.execute(sql6, val6)
        mydb.commit()  # Değişiklikleri veritabanına kaydet

      

    time.sleep(10)



   