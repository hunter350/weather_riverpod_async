import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

import '../../../data/repository/model/models_repository.dart';

class WeatherEmptyNew extends StatelessWidget {
  WeatherEmptyNew({super.key, this.weatherCondition});

  final WeatherCondition? weatherCondition;

  WeatherType weatherType = WeatherType.sunny;

  WeatherType getWeatherType(WeatherCondition weatherCondition) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
        return WeatherType.sunny;
      case WeatherCondition.rainy:
        return WeatherType.middleRainy;
      case WeatherCondition.cloudy:
        return WeatherType.cloudy;
      case WeatherCondition.snowy:
        return WeatherType.middleSnow;
      case WeatherCondition.unknown:
        return WeatherType.lightSnow;
      default:
        return WeatherType.lightRainy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    weatherType = getWeatherType(weatherCondition!);
    debugPrint('### - $weatherCondition');
    return WeatherBg(
      weatherType: weatherType,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}
