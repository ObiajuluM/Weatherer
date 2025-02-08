import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherer/models/api_use.dart';
import 'package:weatherer/models/weather_model.dart';
import 'package:weatherer/providers/weather.dart';
import 'package:weatherer/services/weather_services.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  // api key

  Weather? _weather;

  @override
  void initState() {
    super.initState();
  }

  // fetch weather
  _fetchWeather() async {
    final apiKey = await retrieveApiKeyFromLocal() ?? "";
    //
    final _weatherService = WeatherService(apiKey: apiKey);

    // current city
    final locationCity = await _weatherService.getCurrentLatlan();

    // get weather
    try {
      final weather = await _weatherService.getWeather(
        lat: locationCity[0],
        lon: locationCity[1],
      );
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // animate weather

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json"; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloudy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rainy.json";
      case "thunderstorm":
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default: // defaults to sunny
        return "assets/sunny.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = ref.watch(greetingProvider);
    //
    Future(() async {
      await _fetchWeather();
    });

    return Scaffold(
      backgroundColor:
          greeting == "Morning" ? Colors.white : Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "Loading city...",
              style: TextStyle(
                // color: Colors.white,
                color:
                    greeting == "Morning" ? Colors.grey.shade900 : Colors.white,
              ),
            ),

            // animation
            GestureDetector(
              onDoubleTap: () {
                deleteApiKey();
              },
              child: SizedBox(
                height: 200,
                child: Lottie.asset(
                  getWeatherAnimation(_weather?.mainCondition),
                ),
              ),
            ),

            // temp
            Text(
              "${_weather?.temperature.toString()} °C",
              style: TextStyle(
                // color: Colors.white,
                color:
                    greeting == "Morning" ? Colors.grey.shade900 : Colors.white,
              ),
            ),
            // weather condition
            Text(
              "${_weather?.mainCondition}",
              style: TextStyle(
                // color: Colors.white,
                color:
                    greeting == "Morning" ? Colors.grey.shade900 : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
