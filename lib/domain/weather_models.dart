import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../data/repository/model/models_repository.dart' as weather_repository;
import '../data/repository/model/models_repository.dart';


part 'weather_models.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}

@JsonSerializable()
class WeatherModels extends Equatable {
  const WeatherModels({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  factory WeatherModels.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelsFromJson(json);

  factory WeatherModels.fromRepository(weather_repository.WeatherSrcRepository weather) {
    return WeatherModels(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
    );
  }

  static final empty = WeatherModels(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--',
  );

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;

  @override
  List<Object> get props => [condition, lastUpdated, location, temperature];

  Map<String, dynamic> toJson() => _$WeatherModelsToJson(this);

  WeatherModels copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    Temperature? temperature,
  }) {
    return WeatherModels(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}
