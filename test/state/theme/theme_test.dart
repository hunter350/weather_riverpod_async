import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_riverpod_async/data/repository/model/models_repository.dart';
import 'package:weather_riverpod_async/domain/weather_models.dart';
import 'package:weather_riverpod_async/state/theme/theme_state.dart';

// ignore: must_be_immutable

class MockWeather extends Mock implements WeatherSrcRepository {
  MockWeather(this._condition);

  final WeatherCondition _condition;

  @override
  WeatherCondition get condition => _condition;
}

class Listener extends Mock {
  void call(Color? previous, Color value);
}

void main() {
  //initHydratedStorage();
  final container = ProviderContainer();
  // addTearDown(container.dispose);
  final listener = Listener();

  // Observe a provider and spy the changes.
  container.listen(
    themeState,
    listener,
    fireImmediately: true,
  );

  group('ThemeCubit', () {
    test('initial state is correct', () {
      final stateColor =
          container.readProviderElement(themeState).getState()!.requireState;
      // expect(ThemeCubit().state, ThemeCubit.defaultColor);
      expect(stateColor, ThemeState.defaultColor);
    });

    // group('toJson/fromJson', () {
    //   test('work properly', () {
    //     final themeCubit = ThemeCubit();
    //     expect(
    //       themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
    //       themeCubit.state,
    //     );
    //   });
    // });

    group('updateTheme', () {
      final clearWeather = MockWeather(WeatherCondition.clear);
      final snowyWeather = MockWeather(WeatherCondition.snowy);
      final cloudyWeather = MockWeather(WeatherCondition.cloudy);
      final rainyWeather = MockWeather(WeatherCondition.rainy);
      final unknownWeather = MockWeather(WeatherCondition.unknown);

      test('emits correct color for WeatherCondition.clear', () {
        // container.readProviderElement(themeState).setState(ThemeState().updateTheme(WeatherModels().to))
        container.read(themeState.notifier).updateTheme(WeatherModels(
              condition: WeatherCondition.clear,
              lastUpdated: DateTime(0),
              temperature: const Temperature(value: 0),
              location: '--',
            ));
        Color? color =
            container.readProviderElement(themeState).getState()!.requireState;
        expect(color, Colors.orangeAccent);
      });

      // blocTest<ThemeCubit, Color>(
      //   'emits correct color for WeatherCondition.clear',
      //   build: ThemeCubit.new,
      //   act: (cubit) => cubit.updateTheme(clearWeather),
      //   expect: () => <Color>[Colors.orangeAccent],
      // );

      test('emits correct color for WeatherCondition.clear', () {
        // container.readProviderElement(themeState).setState(ThemeState().updateTheme(WeatherModels().to))
        container.read(themeState.notifier).updateTheme(WeatherModels(
              condition: WeatherCondition.snowy,
              lastUpdated: DateTime(0),
              temperature: const Temperature(value: 0),
              location: '--',
            ));
        Color? color =
            container.readProviderElement(themeState).getState()!.requireState;
        expect(color, Colors.lightBlueAccent);
      });
      // blocTest<ThemeCubit, Color>(
      //   'emits correct color for WeatherCondition.snowy',
      //   build: ThemeCubit.new,
      //   act: (cubit) => cubit.updateTheme(snowyWeather),
      //   expect: () => <Color>[Colors.lightBlueAccent],
      // );

      test('emits correct color for WeatherCondition.cloudy', () {
        // container.readProviderElement(themeState).setState(ThemeState().updateTheme(WeatherModels().to))
        container.read(themeState.notifier).updateTheme(WeatherModels(
              condition: WeatherCondition.cloudy,
              lastUpdated: DateTime(0),
              temperature: const Temperature(value: 0),
              location: '--',
            ));
        Color? color =
            container.readProviderElement(themeState).getState()!.requireState;
        expect(color, Colors.blue);
      });
      // blocTest<ThemeCubit, Color>(
      //   'emits correct color for WeatherCondition.cloudy',
      //   build: ThemeCubit.new,
      //   act: (cubit) => cubit.updateTheme(cloudyWeather),
      //   expect: () => <Color>[Colors.blueGrey],
      // );

      test('emits correct color for WeatherCondition.rainy', () {
        // container.readProviderElement(themeState).setState(ThemeState().updateTheme(WeatherModels().to))
        container.read(themeState.notifier).updateTheme(WeatherModels(
              condition: WeatherCondition.rainy,
              lastUpdated: DateTime(0),
              temperature: const Temperature(value: 0),
              location: '--',
            ));
        Color? color =
            container.readProviderElement(themeState).getState()!.requireState;
        expect(color, Colors.grey);
      });
      // blocTest<ThemeCubit, Color>(
      //   'emits correct color for WeatherCondition.rainy',
      //   build: ThemeCubit.new,
      //   act: (cubit) => cubit.updateTheme(rainyWeather),
      //   expect: () => <Color>[Colors.indigoAccent],
      // );

      test('emits correct color for WeatherCondition.unknown', () {
        // container.readProviderElement(themeState).setState(ThemeState().updateTheme(WeatherModels().to))
        container.read(themeState.notifier).updateTheme(WeatherModels(
              condition: WeatherCondition.unknown,
              lastUpdated: DateTime(0),
              temperature: const Temperature(value: 0),
              location: '--',
            ));
        Color? color =
            container.readProviderElement(themeState).getState()!.requireState;
        expect(color, ThemeState.defaultColor);
      });
      // blocTest<ThemeCubit, Color>(
      //   'emits correct color for WeatherCondition.unknown',
      //   build: ThemeCubit.new,
      //   act: (cubit) => cubit.updateTheme(unknownWeather),
      //   expect: () => <Color>[ThemeCubit.defaultColor],
      // );
    });
  });
}
