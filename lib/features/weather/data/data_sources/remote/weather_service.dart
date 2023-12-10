import 'package:bloc_tutorial_todo/core/network/weather_api.dart';
import 'package:bloc_tutorial_todo/features/weather/data/models/weather.dart';
import 'package:dio/dio.dart';

abstract class WeatherService {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherServiceImpl extends WeatherService {
  final Dio _dio;

  WeatherServiceImpl(this._dio);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    _dio.options = WeatherAPI.weatherOptions;
    var response = await _dio.get(
      WeatherAPI.getCurrentWeatherByName,
      queryParameters: {
        'q': cityName,
        'appid': WeatherAPI.apiKey,
      },
    );
    return WeatherModel.fromJson(response.data);
  }
}
