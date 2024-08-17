import 'package:flutter/material.dart';
import 'package:weather_app/views/search.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'globals.dart';
import 'model.dart';
import 'modle.dart'; // Ensure you import the WeatherData model

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required Scaffold child}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    if (globalWeatherData != null) {
      setState(() {
        _weatherData = globalWeatherData;
        globalWeatherData = null; // Clear the global variable after use
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (_weatherData != null) {
      backgroundColor = getThemeColor(_weatherData!.condition);
    } else {
      backgroundColor = Colors.orange;
    } // Default color if weather data is not available

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchResultPage(),
                ),
              );
              if (globalWeatherData != null) {
                setState(() {
                  _weatherData = globalWeatherData;
                  globalWeatherData = null; // Clear after use
                });
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: _weatherData == null
            ? const NoWeatherBody()
            : Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor, backgroundColor.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weatherData!.location,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Updated: ${DateTime.now().hour}:${DateTime.now().minute}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(getImagePath(_weatherData!.condition), width: 50, height: 50),
                    const SizedBox(width: 10),
                    Text(
                      '${_weatherData!.temperature}°C',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          'max: ${_weatherData!.maxTemp}°C',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'min: ${_weatherData!.minTemp}°C',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _weatherData!.condition,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
