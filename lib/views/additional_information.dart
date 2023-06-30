import 'package:flutter/material.dart';

TextStyle titleFont =
    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0);

TextStyle infoFont =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0);

Widget additionalInformation(
  String wind,
  String humidity,
  String pressure,
  String feels_like,
) =>
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.air,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text("Wind", style: titleFont),
                    ],
                  ),
                  SizedBox(height: 18.0),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_up,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text("Pressure", style: titleFont),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$wind", style: infoFont),
                  SizedBox(height: 18.0),
                  Text("$pressure", style: infoFont),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.waves,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text("Humidity", style: titleFont),
                    ],
                  ),
                  SizedBox(height: 18.0),
                  Row(
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text("Feels Like", style: titleFont),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$humidity", style: infoFont),
                  SizedBox(height: 18.0),
                  Text("$feels_like", style: infoFont),
                ],
              ),
            ],
          ),
        ],
      ),
    );
