import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_model.dart';

class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feelsLike;
  int? pressure;
  List<WeatherForecast>? forecast;
  double? latitude;
  double? longitude;

  Weather({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.feelsLike,
    this.pressure,
    this.forecast,
    this.latitude,
    this.longitude,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"].toDouble();
    wind = json["wind"]["speed"].toDouble();
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feelsLike = json["main"]["feels_like"].toDouble();
    latitude = json['coord']['lat'].toDouble();
    longitude = json['coord']['lon'].toDouble();
  }

  IconData getWeatherIconForCondition(int conditionCode) {
    if (conditionCode < 300) {
      return Icons.cloud;
    } else if (conditionCode < 600) {
      return Icons.beach_access;
    } else if (conditionCode < 700) {
      return Icons.ac_unit;
    } else if (conditionCode < 800) {
      return Icons.cloud_queue;
    } else if (conditionCode == 800) {
      return Icons.wb_sunny;
    } else if (conditionCode <= 804) {
      return Icons.cloud;
    } else {
      return Icons.help;
    }
  }
}
