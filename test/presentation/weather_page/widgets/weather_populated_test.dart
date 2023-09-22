// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_weather/weather/models/weather_models.dart';
import 'package:riverpod_weather/weather/state/weather_state.dart';
import 'package:riverpod_weather/weather/widgets/populated/weather_populated_new.dart';
import 'package:riverpod_weather/weather/widgets/widgets.dart';
import 'package:riverpod_weather/weather_repository/weather_repository.dart';

class Listener extends Mock {
  void call(WeatherState? previous, WeatherState value);
}

void main() {
  // final container = ProviderContainer();
  // // addTearDown(container.dispose);
  // final listener = Listener();
  //
  // // Observe a provider and spy the changes.
  // container.listen(
  //   weatherNotifier,
  //   listener,
  //   fireImmediately: true,
  // );

  group('WeatherPopulated', () {
    final weather = WeatherModels(
      condition: WeatherCondition.clear,
      temperature: Temperature(value: 42),
      location: 'Chicago',
      lastUpdated: DateTime(2020),
    );

    testWidgets('renders correct emoji (clear)', (tester) async {
      // final focus = container.readProviderElement(weatherNotifier);
      // focus.setState(WeatherState(
      //     status: WeatherStatus.loading,
      //   temperatureUnits: TemperatureUnits.fahrenheit,
      //   weatherModels: weather
      // ));
      await tester.pumpWidget(
        ProviderScope(
         // parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: WeatherPopulatedNew(
                weatherModels: weather,
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('☀️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (rainy)', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
        //  parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: WeatherPopulated(
                weatherModels: weather.copyWith(condition: WeatherCondition.rainy),
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('🌧️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (cloudy)', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
       //   parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: WeatherPopulated(
                weatherModels: weather.copyWith(condition: WeatherCondition.cloudy),
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('☁️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (snowy)', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: WeatherPopulated(
                weatherModels: weather.copyWith(condition: WeatherCondition.snowy),
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('🌨️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (unknown)', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: WeatherPopulated(
                weatherModels: weather.copyWith(condition: WeatherCondition.unknown),
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('❓'), findsOneWidget);
    });
  });
}
