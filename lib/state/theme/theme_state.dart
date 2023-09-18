import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/model/models_repository.dart';
import '../../domain/weather_models.dart';


class ThemeState extends StateNotifier<Color> {
ThemeState() : super(defaultColor);

static const defaultColor = Color(0xFF2196F3);

void updateTheme(WeatherModels? weather) {
  //Color updateTheme(WeatherModels? weather) {
 // print("updateTheme Weather $weather");
  if (weather != null) {
    state = weather.toColor;
   // print("updateTheme $state");
   // return state;
  }else{
   // print("NotupdateTheme $state");
   // return state;
  }
}

@override
Color fromJson(Map<String, dynamic> json) {
  return Color(int.parse(json['color'] as String));
}

@override
Map<String, dynamic> toJson(Color state) {
  return <String, String>{'color': '${state.value}'};
}
}

extension on WeatherModels {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
        return ThemeState.defaultColor;
    }
  }
}

final themeState = StateNotifierProvider<ThemeState, Color>((ref) => ThemeState());

// final colorState = Provider((ref)  {
//   final theme1 = ref.watch(themeState.notifier);
//   final weather = ref.watch(weatherNotifier.notifier).state.weatherModels;
//
//   final color =  theme1.updateTheme(weather);
// print("colorState = $color");
//   return color;
// }
// );