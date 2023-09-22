// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_riverpod_async/domain/weather_models.dart';
import 'package:weather_riverpod_async/presentation/setting_page/settings_page.dart';
import 'package:weather_riverpod_async/state/shared_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_state.dart';
import '../../shared_pref_init.dart';

// class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
// }

class Listener extends Mock {
  void call(WeatherState? previous, WeatherState next);
}
//final weatherProvider = Provider((ref) => weatherNotifier);

void main() async {
  SharedPreferences sharedPref = await initShared();
  final container = ProviderContainer();

  final listener = Listener();

  group('SettingsPage', () {
    setUp(() {
      //  weatherCubit = MockWeatherCubit();
    });

    testWidgets('is routable', (tester) async {
      //when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // override the previous value with the new object
            sharedPreferencesProvider.overrideWithValue(sharedPref),
          ],
          parent: container,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('calls toggleUnits when switch is changed', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // override the previous value with the new object
            sharedPreferencesProvider.overrideWithValue(sharedPref),
          ],
          parent: container,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch));
      //В блоке этот тест проверяет была ли вызвана функция toggleUnits()
      //Но я проверил, изменилось ли значение с Цельсия на Фаренгейт!
      var fahrenheitTemp = container
          .readProviderElement(weatherNotifier)
          .requireState
          .temperatureUnits;
      expect(fahrenheitTemp, TemperatureUnits.fahrenheit);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      // final celsiusTemp = container.readProviderElement(weatherNotifier).requireState.temperatureUnits;
      fahrenheitTemp = container
          .readProviderElement(weatherNotifier)
          .requireState
          .temperatureUnits;
      expect(fahrenheitTemp, TemperatureUnits.celsius);
      // verify(() => weatherCubit.toggleUnits()).called(1);
    });

    // testWidgets('calls toggleUnits when switch is changed', (tester) async {
    //   whenListen(
    //     weatherCubit,
    //     Stream.fromIterable([
    //       WeatherState(),
    //       WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
    //     ]),
    //   );
    //   when(() => weatherCubit.state).thenReturn(WeatherState());
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Builder(
    //         builder: (context) => Scaffold(
    //           floatingActionButton: FloatingActionButton(
    //             onPressed: () {
    //               Navigator.of(context).push<void>(
    //                 SettingsPage.route(weatherCubit),
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    //   await tester.tap(find.byType(FloatingActionButton));
    //   await tester.pumpAndSettle();
    //   await tester.tap(find.byType(Switch));
    //   verify(() => weatherCubit.toggleUnits()).called(1);
    // });
  });
}
