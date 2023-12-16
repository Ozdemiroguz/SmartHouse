import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Adocu123!",
    auth_plugin='mysql_native_password',
    database="smarthomev2"
)

mycursor = mydb.cursor()

sql = "INSERT INTO temp_hum (Temperature,Humidity) VALUES (%s, %s)"