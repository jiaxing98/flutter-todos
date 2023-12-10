import 'package:bloc_tutorial_todo/core/mixins/handle_exception.dart';
import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository with HandleExceptionMixin {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
