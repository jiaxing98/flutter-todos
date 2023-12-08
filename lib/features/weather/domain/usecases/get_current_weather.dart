import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';

class GetCurrentWeatherUseCase extends UseCase<WeatherEntity, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  @override
  Future<WeatherEntity> call([String? params]) {
    return weatherRepository.getCurrentWeather(params!);
  }
}
