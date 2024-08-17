import 'package:flutter/material.dart';

class WeatherData {
  final String location;
  final double temperature;
  final String condition;
  final double minTemp;
  final double maxTemp;

  WeatherData({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var forecastDay = json['forecast']['forecastday'][0]['day'];
    return WeatherData(
      location: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      minTemp: forecastDay['mintemp_c'],
      maxTemp: forecastDay['maxtemp_c'],
    );
  }
}

String getImagePath(String weatherStateName) {
  if (weatherStateName == 'Clear' || weatherStateName == 'Light Cloud') {
    return 'assets/images/clear.png';
  } else if (weatherStateName == 'Sleet' || weatherStateName == 'Snow' || weatherStateName == 'Hail') {
    return 'assets/images/snow.png'; // Changed to snow.png
  } else if (weatherStateName == 'Heavy Cloud'||weatherStateName == 'Partly cloudy') {
    return 'assets/images/cloudy.png';
  } else if (weatherStateName == 'Light Rain' || weatherStateName == 'Heavy Rain' || weatherStateName == 'Showers'||weatherStateName == 'Patchy rain nearby') {
    return 'assets/images/rainy.png';
  } else if (weatherStateName == 'Thunderstorm'|| weatherStateName == 'Light rain') {
    return 'assets/images/thunderstorm.png';
  } else {
    return 'assets/images/clear.png'; // Default image
  }
}
Color getThemeColor(String weatherStateName) {
  if (weatherStateName == 'Clear' || weatherStateName == 'Light Cloud') {
    return Color.lerp(Colors.orange, Colors.yellow, 0.5)!;
  } else if (weatherStateName == 'Sleet' || weatherStateName == 'Light rain' || weatherStateName == 'Snow' || weatherStateName == 'Hail') {
    return Color.lerp(Colors.blue, Color(0xFF7BE3FE), 0.5)!;
  } else if (weatherStateName == 'Heavy Cloud' || weatherStateName == 'Partly cloudy') {
    return Color.lerp(Colors.blueGrey, Color(0xFF7615E1), 0.5)!;
  } else if (weatherStateName == 'Light Rain' || weatherStateName == 'Patchy rain nearby' || weatherStateName == 'Heavy Rain' || weatherStateName == 'Showers') {
    return Color.lerp(Colors.blue, Colors.blueGrey, 0.5)!;
  } else if (weatherStateName == 'Thunderstorm') {
    return Color.lerp(Colors.deepPurple, Colors.indigo, 0.5)!;
  } else {
    return Color.lerp(Colors.orange, Color(0xFF7602F5), 0.5)!; // Default color
  }
}


//vienna
//paris
//landon
//ales