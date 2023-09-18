import 'package:json_annotation/json_annotation.dart';

part 'weather_meteo_api.g.dart';

@JsonSerializable()
class WeatherMeteoApi {
  const WeatherMeteoApi({required this.temperature, required this.weatherCode});

  factory WeatherMeteoApi.fromJson(Map<String, dynamic> json) =>
      _$WeatherMeteoApiFromJson(json);

  final double temperature;
  @JsonKey(name: 'weathercode')
  final double weatherCode;
}
