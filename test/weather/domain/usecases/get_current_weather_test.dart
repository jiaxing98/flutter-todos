import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

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

  group('implement weather usecases', () {
    test('get current weather', () async {
      // arrange
      when(() => mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((_) async => const Right(testWeatherEntity));

      // act
      final result = await getCurrentWeatherUseCase(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });
}
