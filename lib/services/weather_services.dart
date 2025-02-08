import 'dart:convert';


import 'package:geolocator/geolocator.dart';
import 'package:weatherer/models/api_use.dart';
import 'package:weatherer/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather({required double lat, required double lon}) async {
    final apiKey = await retrieveApiKeyFromLocal();
    final response = await http.get(
      Uri.parse("$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric"),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load weather");
    }
  }

  Future<List<double>> getCurrentLatlan() async {
    //  check permission status and request
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    // return lat and lon
    return [position.latitude, position.longitude];
  }
}
