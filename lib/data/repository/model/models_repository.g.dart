// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherSrcRepository _$WeatherSrcRepositoryFromJson(
        Map<String, dynamic> json) =>
    WeatherSrcRepository(
      location: json['location'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
    );

Map<String, dynamic> _$WeatherSrcRepositoryToJson(
        WeatherSrcRepository instance) =>
    <String, dynamic>{
      'location': instance.location,
      'temperature': instance.temperature,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};
