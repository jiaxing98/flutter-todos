import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/usecases/get_current_weather.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_event.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepositoryImpl {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
    weatherBloc = WeatherBloc(getCurrentWeatherUseCase);
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
  const testInvalidCityName = 'qwerty';
  const testCityNotFoundErrorMessage = 'City cannot be found.';
  const testOtherErrorMessage = 'Something went wrong.';

  group('should return corresponding state', () {
    test('initial state should be [WeatherEmpty]', () {
      expect(weatherBloc.state, WeatherEmpty());
    });

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when receive data successfully',
      build: () {
        when(() => getCurrentWeatherUseCase.call(testCityName))
            .thenAnswer((_) async => const Right(testWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherLoaded(testWeatherEntity),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      "should emit [WeatherLoading, WeatherError] when cityName is invalid",
      build: () {
        when(() => getCurrentWeatherUseCase.call(testInvalidCityName))
            .thenAnswer((_) async => const Left(
                  ServerFailure(message: testCityNotFoundErrorMessage),
                ));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testInvalidCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherError(testCityNotFoundErrorMessage),
      ],
    );
  });

  blocTest<WeatherBloc, WeatherState>(
    "should emit [WeatherLoading, WeatherError] when encounter unknown error",
    build: () {
      when(() => getCurrentWeatherUseCase.call(testCityName))
          .thenAnswer((_) async => const Left(
                UnknownFailure(message: testOtherErrorMessage),
              ));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherError(testOtherErrorMessage),
    ],
  );
}
