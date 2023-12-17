import 'dart:convert';
import 'package:untitled5/models/weatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class WeatherService{
  static const Base_URL='https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherService(this.apiKey);

  Future<Weather>getWeather(String cityName)async{
    final response=await http.get(Uri.parse('$Base_URL?q=$cityName&appid=$apiKey&units=metric'));
  if(response.statusCode==200)
      {
      return Weather.fromJson(jsonDecode(response.body));

      }
    else
      {
        throw Exception('Failed to load weather data');


    }
  }
  Future<String> getCurrentCity() async{
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
      {
        permission=await Geolocator.requestPermission();
      }



    //fetch current location
    Position position=await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //convert the location into alist of placemark objects
    List<Placemark>placemarks=
      await placemarkFromCoordinates(position.latitude, position.longitude);


    //extract the citynae from the first placemark
    String? city=placemarks[0].locality;


    return city ?? "Zocca";

  }
}