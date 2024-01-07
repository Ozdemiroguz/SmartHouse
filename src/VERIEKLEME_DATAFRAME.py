import serial
import time
import mysql.connector
import pandas as pd
import datetime

arduino_port = "COM4"
arduino = serial.Serial(arduino_port, baudrate=9600, timeout=1)

def connect_db():
    try:
        mydb = mysql.connector.connect(
            host="mysql6008.site4now.net",
            user="aa363f_shome",
            password="Adocu123!",
            auth_plugin='mysql_native_password',
            database="db_aa363f_shome"
        )
        print("Database connected successfully")
        return mydb
    except mysql.connector.Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

def delete_user(mycursor, UserID):
    try:
        sql = "DELETE FROM user WHERE UserID = %s"
        val = (UserID,)
        mycursor.execute(sql, val)
        mydb.commit()
        print("User deleted successfully")
    except mysql.connector.Error as e:
        print(f"Error deleting user: {e}")

def delete_room(mycursor, room_id):
    try:
        sql = "DELETE FROM room WHERE RoomID = %s"
        val = (room_id,)
        mycursor.execute(sql, val)
        mydb.commit()
        print("Room deleted successfully")
    except mysql.connector.Error as e:
        print(f"Error deleting room: {e}")        

time.sleep(3)


print("Connecting to Device...")
time.sleep(3)


columns = ['Saat', 'Sıcaklık', 'Nem', 'Gaz', 'Alev', 'Hareket']
sensor_data = []  #dataframe için bir liste oluşturuldu



def sensor_verileri(mycursor):#Sensör verilerini aldığımız yer
    try:
        data = arduino.readline().decode('utf-8').strip().split(",")
        print("Read data:", data)  

        if len(data) == 5:
            humidity, temperature, gas, flame, motion = map(float, data)
            motion_bool = bool(motion)
            flame_bool = bool(flame)
            anlık_saat = time.strftime("%Y-%m-%d %H:%M:%S")

            yeni_veri = {'Saat': anlık_saat, 'Sıcaklık': temperature, 'Nem': humidity, 'Gaz': gas, 'Alev': flame_bool, 'Hareket': motion_bool}#kontrol amaçlı terminalde gösteriyor

            sensor_data.append(yeni_veri) #dataframe içerisine veriler ekleniyor(csv,xls gibi yerlere de veriler kolay bir şekilde eklenebilir)

        
            if anlık_saat.endswith(":00:00"):
                hourly_avg = calculate_hourly_average(sensor_data)
                save_hourly_average(hourly_avg, anlık_saat, mycursor)

            save_fire_gas_motion(anlık_saat, flame_bool, gas, motion_bool, mycursor)
            save_temp_humidity(anlık_saat, temperature, humidity, mycursor)

    except Exception as e:
        print(f"Error in sensor data processing: {e}")

def calculate_hourly_average(data_list):
    df = pd.DataFrame(data_list)
    hourly_avg = df.resample('H', on='Saat').mean()
    hourly_avg = hourly_avg.dropna()
    return hourly_avg

def save_hourly_average(hourly_avg, saat, mycursor):
    try:
        for index, row in hourly_avg.iterrows():
            sql = "INSERT INTO hourly_datas (datetime, avarage_temp, avarage_humidity, avarage_gas) VALUES (%s, %s, %s, %s)"
            values = (index.strftime("%Y-%m-%d %H:%M:%S"), row['Sıcaklık'], row['Nem'], row['Gaz'])
            mycursor.execute(sql, values)
            mydb.commit()
            print("Hourly average data inserted successfully")
    except mysql.connector.Error as e:
        print(f"Error inserting hourly average: {e}")

def save_fire_gas_motion(saat, flame, gas, motion, mycursor):
    try:
        sql_fire = "INSERT INTO fire (FireDetected,datetime) VALUES (%s,%s)"
        values_fire = (int(flame),saat)
        mycursor.execute(sql_fire, values_fire)
        
        sql_gas = "INSERT INTO gas (GasLevel, datetime) VALUES (%s, %s)"
        values_gas = (gas, saat)
        mycursor.execute(sql_gas, values_gas)
        
        sql_motion = "INSERT INTO motion (MotionDetected, datetime) VALUES (%s, %s)"
        values_motion = (int(motion), saat)
        mycursor.execute(sql_motion, values_motion)
        
        mydb.commit()
        print("Fire, gas, and motion data inserted successfully")

        
    except mysql.connector.Error as e:
        print(f"Error inserting fire, gas, or motion data: {e}")
        

def save_temp_humidity(saat, temperature, humidity, mycursor):
    try:
        sql_temp_humidity = "INSERT INTO temp_humidity (datetime, Temperature, Humidity) VALUES (%s, %s, %s)"
        values_temp_humidity = (saat, temperature, humidity)
        mycursor.execute(sql_temp_humidity, values_temp_humidity)
        mydb.commit()
        print("Temperature and humidity data inserted successfully")
        time.sleep(10)
    except mysql.connector.Error as e:
        print(f"Error inserting temperature and humidity data: {e}")


def clear_data(mycursor):
    try:
        tables_to_clear = ['fire', 'gas', 'motion', 'temp_humidity', 'hourly_datas']
        for table in tables_to_clear:
            sql = f"DELETE FROM {table}"
            mycursor.execute(sql)
        mydb.commit()
        print("All data cleared successfully")
    except mysql.connector.Error as e:
        print(f"Error clearing data from tables: {e}")




def main():
    global mydb, mycursor
    mydb = connect_db()
    if mydb is None:
        return

    mycursor = mydb.cursor()
    while True:
        current_time = datetime.datetime.now()
        # Pazartesi ve saat 00:00:00 kontrolü
        # if current_time.weekday() == 0 and current_time.strftime("%H:%M:%S") == "00:00:00":
        if current_time.strftime(":%S")==":00":
            clear_data(mycursor)  # Verileri sil

        sensor_verileri(mycursor)
    



