import 'dart:convert';

import 'package:bloc_tutorial_todo/features/weather/data/models/weather.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('validate json, model and entity', () {
    test('is subclass of WeatherEntity', () async {
      // assert
      expect(testWeatherModel, isA<WeatherEntity>());
    });

    test('return valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJsonFile('dummy_data/dummy_weather_response.json'),
      );

      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testWeatherModel));
    });

    test('return valid json from model', () async {
      // act
      final result = testWeatherModel.toJson();

      // assert
      final expectedJson = {
        'weather': [
          {
            'main': 'Clouds',
            'description': 'few clouds',
            'icon': '02d',
          }
        ],
        'main': {
          'temp': 302.28,
          'pressure': 1009,
          'humidity': 70,
        },
        'name': 'New York',
      };

      expect(result, equals(expectedJson));
    });
  });
}
