import 'dart:convert';
import 'package:http/http.dart' as http;

import '../views/modle.dart'; // Ensure this path correctly points to where your WeatherData model is defined.

class GetWeather {
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = 'ac00f43786074925ba310133241007';

  Future<WeatherData> getWeather({required String cityName}) async {
    final Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no');

    print('Request URL: $url'); // Debug line

    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Response Data: $data'); // Debug line
        return WeatherData.fromJson(data);
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load weather data');
    }
  }
}
