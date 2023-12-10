import 'package:bloc_tutorial_todo/features/weather/domain/entities/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  factory WeatherModel.fromEntity(WeatherEntity entity) => WeatherModel(
        cityName: entity.cityName,
        main: entity.main,
        description: entity.description,
        iconCode: entity.iconCode,
        temperature: entity.temperature,
        pressure: entity.pressure,
        humidity: entity.humidity,
      );

  WeatherEntity toEntity() => WeatherEntity(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );
}
