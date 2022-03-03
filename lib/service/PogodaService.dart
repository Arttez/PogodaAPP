import 'dart:convert';
import 'package:PogodaApp/models/Pogoda.dart';
import 'package:http/http.dart' as http;

class PogodaService {
  static String _apiKey = "39b5976d7b14638e811705e7c8ae2a9f";

  static Future<Pogoda> fetchCurrentWeather({query, String lat = "", String lon = ""}) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return Pogoda.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<Pogoda>> fetchHourlyWeather({String query, String lat = "", String lon = ""}) async {
    var url = 'https://api.openweathermap.org/data/2.5/forecast?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Pogoda> data = (jsonData['list'] as List<dynamic>).map((item) {
        return Pogoda.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
