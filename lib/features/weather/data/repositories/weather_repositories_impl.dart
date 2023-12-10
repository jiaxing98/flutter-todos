import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherService _weatherService;

  WeatherRepositoryImpl(this._weatherService);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await _weatherService.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on DioException catch (ex) {
      var failure = handleRemoteException(ex);
      return Left(failure);
    }
  }
}
