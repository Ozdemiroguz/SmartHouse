
class Weather{
  final String cityName;
  final double temprature;
  final String mainCondition;
  final double humidity;


  Weather({ required this.cityName, required this.temprature, required this.mainCondition,required this.humidity});

  factory Weather.fromJson(Map<String,dynamic>json){
    return Weather(
        cityName: json['name'],
        temprature:json['main']['temp'].toDouble(),
        humidity:json['main']['humidity'].toDouble(),
        mainCondition:json['weather'][0]['main']
    );
  }
}




