import serial
import time #zaman fonksiyonlarını kullanmak için gerekli kütüphane
ardunio=serial.Serial('COM4',9600) #ardunio ile haberleşme için gerekli port ve baudrate ayarları
i=0
while True:
    veri=ardunio.readline() #ardunio ile haberleşme için gerekli kod
    decoded_data = veri.decode('utf-8')
    print(decoded_data) #ardunio ile haberleşme için gerekli kod
    time.sleep(10) #ardunio ile haberleşme için gerekli zaman aralığı
    
    i=i+1
    

