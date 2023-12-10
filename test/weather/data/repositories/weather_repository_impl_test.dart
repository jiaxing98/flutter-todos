import 'package:bloc_tutorial_todo/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:bloc_tutorial_todo/features/weather/data/models/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  late MockWeatherService mockWeatherService;
  late WeatherRepository weatherRepository;

  setUp(() {
    mockWeatherService = MockWeatherService();
    weatherRepository = WeatherRepositoryImpl(mockWeatherService);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('implement weather repositories', () {
    test('get current weather', () async {
      // arrange
      when(() => mockWeatherService.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result = await weatherRepository.getCurrentWeather(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });
}
