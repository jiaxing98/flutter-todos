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
}
