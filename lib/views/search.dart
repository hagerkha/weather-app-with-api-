import 'package:flutter/material.dart';
import '../servce/GetWeather.dart';
import 'globals.dart';
import 'modle.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _controller = TextEditingController();
  WeatherData? _weatherData;
  String? _error;

  Future<void> _searchWeather(String cityName) async {
    GetWeather service = GetWeather();
    try {
      WeatherData weather = await service.getWeather(cityName: cityName);
      setState(() {
        _weatherData = weather;
        _error = null;
        globalWeatherData = weather; // Store data in global variable
      });
      Navigator.pop(context); // Automatically navigate back to HomeView
    } catch (e) {
      setState(() {
        _weatherData = null;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
        backgroundColor: Colors.white, // Set AppBar color to white
        foregroundColor: Colors.black, // Set text color to black
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/img_1.png', // Make sure this path matches your image location
                width: 200, // Adjust the size as needed
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              onSubmitted: _searchWeather, // Trigger search on enter
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 24.0),
                suffixIcon: const Icon(Icons.search, color: Colors.black), // Set icon color to black
                labelText: 'Search',
                labelStyle: const TextStyle(color: Colors.black), // Set label text color to black
                border: const OutlineInputBorder(),
                hintText: 'Enter a city',
                hintStyle: const TextStyle(color: Colors.black), // Set hint text color to black
                filled: true,
                fillColor: Colors.white60, // Set text field background color to white
              ),
              style: const TextStyle(color: Colors.black), // Set text color to black
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
