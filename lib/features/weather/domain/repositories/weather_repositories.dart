import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(String cityName);
}
