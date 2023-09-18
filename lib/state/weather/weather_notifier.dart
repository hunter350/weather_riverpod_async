import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_riverpod_async/state/weather/weather_state.dart';

import '../../data/repository/weather_repository.dart';
import '../../domain/weather_models.dart';


class WeatherNotifier extends StateNotifier<WeatherState>{
 // WeatherNotifier(this._weatherRepository) : super(WeatherState());
  WeatherNotifier() : super(WeatherState());

  final WeatherRepository _weatherRepository = WeatherRepository();

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    state = state.copyWith(status: WeatherStatus.loading);

    try {
      final weather = WeatherModels.fromRepository(
        await _weatherRepository.getWeather(city),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;


      state =  state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherModels: weather.copyWith(temperature: Temperature(value: value)),
        );
   //   print('search_page_status getWeather: ${state.toString()}');
    } on Exception {
      state = state.copyWith(status: WeatherStatus.failure);
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weatherModels == WeatherModels.empty) return;
    try {
      final weather = WeatherModels.fromRepository(
        await _weatherRepository.getWeather(state.weatherModels.location),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;


       state =  state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherModels: weather.copyWith(temperature: Temperature(value: value)),
        );

    } on Exception {
      state = state;
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;
   // state = state.copyWith(status: WeatherStatus.success);
    if (!state.status.isSuccess) {
      state = state.copyWith(temperatureUnits: units);
      return;
    }

    final weather = state.weatherModels;
    if (weather != WeatherModels.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();
      state = state.copyWith(
          temperatureUnits: units,
        weatherModels: weather.copyWith(temperature: Temperature(value: value)),
        );
    //  );
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

//final weatherNotifier = StateNotifierProvider((ref) => WeatherNotifier());
final weatherNotifier = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => WeatherNotifier());
