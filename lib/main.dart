import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Enable DevicePreview
      builder: (context) => const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      useInheritedMediaQuery: true, // Use the simulated device's media query
      locale: DevicePreview.locale(context), // Use the locale from DevicePreview
      builder: DevicePreview.appBuilder, // Wrap your app with the DevicePreview builder
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF252525), // Single background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF252525), // Same color as background
        ),
      ),
      home: const SplashScreen(), // Show the splash screen first
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 8), () {}); // Delay for 3 seconds
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeView(
          child: Scaffold(
            body: NoWeatherBody(), // Display NoWeatherBody
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_2.png', // Path to your image
              fit: BoxFit.cover,
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
            ),
            const SizedBox(height: 20), // Space between image and text
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'WELCOME BACK ',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
