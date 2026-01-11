import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  final _weatherService = WeatherService(
    apiKey: '004d62385622f114cb8a0cd1d1822f19',
  );
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/lotties/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lotties/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lotties/rain.json';
      case 'thunderstorm':
        return 'assets/lotties/thunderstorn.json';
      case 'clear':
        return 'assets/lotties/sunny.json';
      default:
        return 'assets/lotties/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on, // Iconița de locație
              color: Colors.grey, // Culoarea (de obicei roșu pentru locație)
              size: 40.0,
            ),
            Text(
              _weather?.cityName ?? 'loading city...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Lottie.asset(getWeatherCondition(_weather?.mainCondition)),

            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
