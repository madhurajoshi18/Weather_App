import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_model.dart';

class WeatherForecastScreen extends StatelessWidget {
  final List<WeatherForecast> forecastList;

  const WeatherForecastScreen({required this.forecastList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: ListView.builder(
        itemCount: forecastList.length,
        itemBuilder: (context, index) {
          if (index >= 5) {
            return null; // Skip rendering items beyond the next five days
          }

          WeatherForecast forecast = forecastList[index];
          return ListTile(
            title: Text(forecast.date.toString()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Temperature: ${forecast.temp!.toStringAsFixed(1)}°C'),
                Text('Weather: ${forecast.weatherDescription}'),
                Text(
                    'Min Temperature: ${forecast.minTemp!.toStringAsFixed(1)}°C'),
                Text(
                    'Max Temperature: ${forecast.maxTemp!.toStringAsFixed(1)}°C'),
              ],
            ),
            leading: Icon(forecast.weatherIcon),
          );
        },
      ),
    );
  }
}
