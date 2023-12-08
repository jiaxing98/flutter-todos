import 'package:bloc_tutorial_todo/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherService _weatherService;

  WeatherRepositoryImpl(this._weatherService);

  @override
  Future<WeatherEntity> getCurrentWeather(String cityName) {
    return _weatherService.getCurrentWeather(cityName);
  }
}
