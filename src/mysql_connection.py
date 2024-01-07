import mysql.connector

mydb = mysql.connector.connect(
    host="mysql6008.site4now.net",
    user="aa363f_shome",
    password="Adocu123!",
    auth_plugin='mysql_native_password',
    database="db_aa363f_shome"
)

mycursor = mydb.cursor()

print (mydb)