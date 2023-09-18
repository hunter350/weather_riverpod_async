import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models_repository.g.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

@JsonSerializable()
class WeatherSrcRepository extends Equatable {
  const WeatherSrcRepository({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  factory WeatherSrcRepository.fromJson(Map<String, dynamic> json) =>
      _$WeatherSrcRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherSrcRepositoryToJson(this);

  final String location;
  final double temperature;
  final WeatherCondition condition;

  @override
  List<Object> get props => [location, temperature, condition];
}