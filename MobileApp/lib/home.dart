import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'models/weatherModel.dart';
import 'services/weatherService.dart';
import 'Info.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // apikey
  final _weatherService = WeatherService('bf9ba31da6a2f4eb21dc70cb79c87151');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get weather for city
    String cityName ="Eskisehir";
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchWeather(); // initState içinde hava durumu getirme işlemini çağırın
  }

  @override
  Widget build(BuildContext context) {
    Color darkBack=ColorConverter.hexToColor("49108B");
    Color softBack=ColorConverter.hexToColor("7E30E1");
    Color pink=ColorConverter.hexToColor("E26EE5");

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Şu anki tarih ve saat bilgisini al
    DateTime now = DateTime.now();

    // Yıl, ay ve günü içeren bir metin oluştur
    String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    return Scaffold(
        backgroundColor: darkBack,
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(0.0), // Sıfır yükseklikte AppBar
          child: AppBar(
            automaticallyImplyLeading: false, // Geri gitme tuşunu kaldırmak için
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),

                SizedBox(width: screenWidth/ 1.05,
                  child: Card(
                    elevation: 15,
                    color:softBack,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(10))),
                    child:Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Welcome Name Surname",style: TextStyle(fontSize: 20,color: Colors.white),),
                                SizedBox(height: 10,),
                                Text("Let's see your smarthome",style: TextStyle(color:Colors.white),),
                              ],
                            ),
                            SizedBox(

                                child: Icon(Icons.person_pin,size: 54,color: Colors.white,)),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(10))),
                  color: softBack,
                  elevation: 15,
                  child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: screenWidth/3,child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition??"Clouds"))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_weather?.mainCondition??"",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                          Text(formattedDate,style: TextStyle(color: Colors.white),),
                          Text(_weather?.cityName??"loading city",style: TextStyle(fontSize: 12,color: Colors.white),),
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${_weather?.temprature.round().toString()}°C',style: TextStyle(fontSize: 36,color: Colors.white), ),
                        Text('${_weather?.humidity.round().toString()}%',style: TextStyle(fontSize: 36,color: Colors.white), ),
                        //Text('${_weather?.humidity.round().toString()}%' ),

                      ],
                    ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
                ),

                Expanded(
                  child: FutureBuilder<List<Room>>(
                    future: getRooms(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Hata: ${snapshot.error}'));
                      } else {
                        var roomList = snapshot.data!;
                        return DefaultTabController(
                          length: roomList.length,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: roomList.map((room) => Tab(text: room.roomName)).toList(),
                              ),
                              Expanded(

                                child: TabBarView(

                                  children: roomList.map((room) {
                                    return
                                      Center(
                                      child: SizedBox(width: screenWidth/1.05,
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: screenHeight/3.5,
                                                    child:                                   // Card(color:softBack,child: ,)
                                                    SfRadialGauge(
                                                  axes: <RadialAxis>[

                                                    RadialAxis(
                                                      axisLineStyle: AxisLineStyle(thickness: 10,),
                                                      axisLabelStyle:GaugeTextStyle(color: Colors.white),

                                                      minimum: 0,
                                                      maximum: 51,
                                                      pointers:  <GaugePointer>[
                                                        RangePointer(
                                                          enableAnimation: true,

                                                            width: 10,
                                                            gradient: const SweepGradient(
                                                                colors: <Color>[Color(0xFF753A88),Color(0xFFCC2B5E) ],
                                                                stops: <double>[0.25, 0.75]
                                                            ),

                                                            value: room.optimumTemperature, dashArray: <double>[5, 2])
                                                      ],
                                                      annotations: <GaugeAnnotation>[
                                                        GaugeAnnotation(
                                                          widget:
                                                          Center(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(height: 20,),
                                                                Text(
                                                                  '${room.optimumTemperature}°C',  // Sabit sıcaklık değeri
                                                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),

                                                                ),
                                                                Text("Temprature",style: TextStyle(color: Colors.white,fontSize: 16),)
                                                              ],
                                                            ),
                                                          ),

                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),



                                            ],
                                            ),
                                          ),

                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                )


              ],
            ),

          ),
        )
    );
  }
  }




Future<User>getUser()async{
  //Get data from database

  var tempUser=User(1,"Tuanna","Köse Özdemir","qwerty1","adjnfs","53353535");



  return tempUser;
}
Future<List<Room>>getRooms()async{
  //Get data from database

  var roomList=<Room>[];

  var room=Room(roomId: 1,roomName: "Yatak Odası",userId:1,optimumTemperature:31.1,optimumHumidity:23.4);
  var room1=Room(roomId: 2,roomName: "Oturma Odası",userId:1,optimumTemperature:31.1,optimumHumidity:23.4);
  var room2=Room(roomId: 3,roomName: "Banyo",userId:1,optimumTemperature:31.1,optimumHumidity:23.4);
  var room3=Room(roomId: 4,roomName: "Mutfak",userId:1,optimumTemperature:31.1,optimumHumidity:23.4);

  roomList.add(room);
  roomList.add(room1);
  roomList.add(room2);
  roomList.add(room3);

  return roomList;
}
class ColorConverter {
  static Color hexToColor(String hexString) {
    // Hex renk kodunu geçerli bir renk nesnesine dönüştürme
    final buffer = StringBuffer();

    // Hex kodun başında # işareti varsa onu kaldırma
    if (hexString.length == 7 || hexString.length == 9) {
      hexString = hexString.replaceFirst('#', '');
    }

    // Opaklık değeri olup olmadığını kontrol etme
    if (hexString.length == 6) {
      buffer.write('ff'); // Opaklık değeri yoksa, varsayılan olarak 'ff' (255) kullan
    }

    buffer.write(hexString);

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
Icon setIcon(String roomName)
{


  final Map<String, IconData> roomIcons = {
    'Mutfak': Icons.kitchen,
    'Banyo': Icons.bathtub,
    'Yatak Odası': Icons.bedroom_parent,
    'Oturma Odası': Icons.living,
  };

  return Icon(
    roomIcons[roomName] ?? Icons.home,
    color: Colors.white,
    size: 56,
  );
}
String getWeatherAnimation(String weatherCondition) {
  switch (weatherCondition) {
    case "Clouds":
      return "weatheranimations/Animation - 1702679736586.json"; // Bulutlu
    case "Drizzle":
      return "weatheranimations/Animation - 1702679500514.json"; // Çisenti
    case "Clear":
      return "weatheranimations/Animation - 1702679286357.json"; // Açık Hava
    case "Rain":
      return "weatheranimations/Animation - 1702679615743.json"; // Yağmurlu
    case "Thunderstorm":
      return "weatheranimations/Animation - 1702679414151.json"; // Gökgürültülü Fırtına
    case "Snow":
      return "weatheranimations/Animation - 1702730698823.json"; // Karlı
    default:
      return "weatheranimations/Animation - 1702679736586.json"; // Varsayılan bir animasyon dosyası ya da hata durumu
  }
}

/*GridView.builder(
                          itemCount: roomList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 15,

                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(10))),
                                color: softBack,
                                child: Column(children: [
                                  setIcon(roomList[index].roomName),
                                  Text(roomList[index].roomName),


                                ],

                                )
                            );

                            //Text("${roomList[index].roomName}", style: TextStyle(fontSize: 35));
                          },
                        );*/

/*Card(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                setIcon(room.roomName),
                                                Text(room.roomName),
                                              ],
                                            ),
                                          ),
                                        ),*/