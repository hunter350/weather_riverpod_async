// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_meteo_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherMeteoApi _$WeatherMeteoApiFromJson(Map<String, dynamic> json) =>
    WeatherMeteoApi(
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: (json['weathercode'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherMeteoApiToJson(WeatherMeteoApi instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weathercode': instance.weatherCode,
    };
