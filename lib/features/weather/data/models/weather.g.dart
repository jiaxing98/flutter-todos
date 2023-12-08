// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json['name'] as String,
      main: json['weather'][0]['main'] as String,
      description: json['weather'][0]['description'] as String,
      iconCode: json['weather'][0]['icon'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      pressure: json['main']['pressure'] as int,
      humidity: json['main']['humidity'] as int,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) => {
      'weather': [
        {
          'main': instance.main,
          'description': instance.description,
          'icon': instance.iconCode,
        }
      ],
      'main': {
        'temp': instance.temperature,
        'pressure': instance.pressure,
        'humidity': instance.humidity,
      },
      'name': instance.cityName,
    };
