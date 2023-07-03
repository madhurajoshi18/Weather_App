import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherApiClient {
  static const String apiKey =
      '9f0f573a39e7bd84fe6e701cc7d33e6e'; // Replace with your OpenWeatherMap API key

  Future<Weather> getCurrentWeather(String location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=imperial");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<List<WeatherForecast>> getWeatherForecast(String cityname) async {
    var endpoint = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=$apiKey&units=imperial",
    );

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    print(body);

    if (response.statusCode == 200) {
      List<WeatherForecast> forecastList = [];

      print(body['list']); // Print the value of body['list']

      if (body['list'] != null && body['list'] is List<dynamic>) {
        for (var item in body['list']) {
          var forecast = WeatherForecast.fromJson(item);
          forecastList.add(forecast);
        }
      }

      return forecastList;
    } else {
      throw Exception('Failed to fetch weather forecast data');
    }
  }
}
