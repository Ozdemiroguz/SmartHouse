import 'package:flutter/material.dart';

// user.dart
class User {
  int userId;
  String name;
  String surname;
  String password;
  String email;
  String phoneNumber;

  User(
     this.userId,
     this.name,
     this.surname,
     this.password,
     this.email,
     this.phoneNumber,
  );
}

// room.dart
class Room {
  int roomId;
  String roomName;
  int userId;
  double optimumTemperature;
  double optimumHumidity;

  Room({
    required this.roomId,
    required this.roomName,
    required this.userId,
    required this.optimumTemperature,
    required this.optimumHumidity,
  });
}

// pot.dart
class Pot {
  int potId;
  String potName;
  int roomId;

  Pot({
    required this.potId,
    required this.potName,
    required this.roomId,
  });
}

// sensor_reading.dart
class SensorReading {
  int sensorId;
  int roomId;
  DateTime timestamp;
  double temperature;
  double humidity;

  SensorReading({
    required this.sensorId,
    required this.roomId,
    required this.timestamp,
    required this.temperature,
    required this.humidity,
  });
}

