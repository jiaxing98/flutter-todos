import 'package:dio/dio.dart';

abstract class WeatherAPI {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';

  static const getCurrentWeatherByName = '/weather';

  static BaseOptions get weatherOptions => BaseOptions(
        baseUrl: WeatherAPI.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        validateStatus: (statusCode) =>
            (statusCode != null && statusCode >= 200 && statusCode <= 300),
      );

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
