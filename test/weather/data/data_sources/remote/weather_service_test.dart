import 'dart:convert';

import 'package:bloc_tutorial_todo/core/network/weather_api.dart';
import 'package:bloc_tutorial_todo/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:bloc_tutorial_todo/features/weather/data/models/weather.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../dummy_data/json_reader.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late WeatherServiceImpl weatherServiceImpl;

  setUp(() async {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    weatherServiceImpl = WeatherServiceImpl(dioAdapter.dio);
  });

  const testPath = '/weather';
  const testCityName = 'New York';

  group('get current weather', () {
    test('return weather model when status code is 200', () async {
      // arrange
      dioAdapter.onGet(
        testPath,
        queryParameters: {
          'q': 'New York',
          'appid': WeatherAPI.apiKey,
        },
        (server) => server.reply(
          200,
          jsonDecode(readJsonFile('/dummy_data/dummy_weather_response.json')),
          // Reply would wait for one-sec before returning data.
          delay: const Duration(seconds: 1),
        ),
      );

      // act
      final result = await weatherServiceImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test('should throw remote exception when status code is 4xx or 5xx',
        () async {
      // arrange
      dioAdapter
        ..onGet(
          testPath,
          queryParameters: {
            'q': 'New York',
            'appid': WeatherAPI.apiKey,
          },
          (server) => server.reply(
            401,
            'Unauthorized',
            delay: const Duration(seconds: 1),
          ),
        )
        ..onGet(
          testPath,
          queryParameters: {
            'q': 'New York',
            'appid': WeatherAPI.apiKey,
          },
          (server) => server.reply(
            500,
            'Internal Server Error',
            delay: const Duration(seconds: 1),
          ),
        );

      // assert
      expect(
        () async => await weatherServiceImpl.getCurrentWeather(testCityName),
        throwsA(isA<DioException>()),
      );
    });
  });
}
