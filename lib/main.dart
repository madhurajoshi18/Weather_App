import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/additional_information.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:weather_app/models/weather_forecast_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  List<WeatherForecast>? forecastData;
  bool isLoading = false;
  String error = '';

  Future<void> getData(String location) async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      data = await client.getCurrentWeather(location);
      forecastData = await client.getWeatherForecast(location);
      if (data != null) {
        data!.forecast = forecastData;
      }
    } catch (e) {
      setState(() {
        data = null;
        forecastData = null;
        error = 'Error fetching weather data: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  data = null; // Clear previous weather data
                  error = ''; // Clear previous error message
                });
                getData(value); // Fetch data for the entered city name
              },
              decoration: InputDecoration(
                hintText: "Search city",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : data != null
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                currentWeather(
                                  Icons.wb_sunny_rounded,
                                  "${data!.temp}°",
                                  "${data!.cityName}",
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  "Additional Information",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Color(0xdd212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                SizedBox(height: 20.0),
                                if (data!.wind != null &&
                                    data!.humidity != null &&
                                    data!.pressure != null &&
                                    data!.feelsLike != null)
                                  additionalInformation(
                                    "${data!.wind}",
                                    "${data!.humidity}",
                                    "${data!.pressure}",
                                    "${data!.feelsLike}",
                                  ),
                                SizedBox(height: 60.0),
                                Text(
                                  "Next 5 Days",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Color(0xdd212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: forecastData?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      var forecast = forecastData?[index];

                                      if (forecast != null) {
                                        return ListTile(
                                          leading: Icon(
                                            getWeatherIconForCondition(
                                                forecast.weatherIcon ??
                                                    Icons.help),
                                          ),
                                          title: Text(
                                            "${forecast.date?.day}/${forecast.date?.month}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                              forecast.weatherDescription ??
                                                  ''),
                                          trailing: Text(
                                            "${forecast.maxTemp?.toStringAsFixed(0)}°/${forecast.minTemp?.toStringAsFixed(0)}°",
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
          ),
        ],
      ),
    );
  }
}

IconData getWeatherIconForCondition(IconData weatherIcon) {
  if (weatherIcon == Icons.cloud) {
    return Icons.cloud;
  } else if (weatherIcon == Icons.beach_access) {
    return Icons.beach_access;
  } else if (weatherIcon == Icons.ac_unit) {
    return Icons.ac_unit;
  } else if (weatherIcon == Icons.cloud_queue) {
    return Icons.cloud_queue;
  } else if (weatherIcon == Icons.wb_sunny) {
    return Icons.wb_sunny;
  } else {
    return Icons.help;
  }
}
