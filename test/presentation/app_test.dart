import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_riverpod_async/presentation/app.dart';
import 'package:weather_riverpod_async/presentation/weather_page/weather_page.dart';
import 'package:weather_riverpod_async/state/shared_notifier.dart';
import 'package:weather_riverpod_async/state/theme/theme_state.dart';
import '../shared_pref_init.dart';

//class MockThemeCubit extends MockCubit<Color> implements ThemeCubit {}

//class MockWeatherRepository extends Mock implements WeatherRepository {}
class Listener extends Mock {
  void call(Color? previous, Color value);
}

//Была ошибка с SharedPreferences - ошибка поздней инициализации
//Оказалось, что в тесте нельзя использовать late final sharedPref;
//Нужно заменить late SharedPreferences sharedPref;
//late SharedPreferences sharedPref;

void main() async {

  SharedPreferences sharedPref = await initShared();

  final container = ProviderContainer();
  // addTearDown(container.dispose);
  final listener = Listener();

  // Observe a provider and spy the changes.
  container.listen(
    themeState,
    listener,
    fireImmediately: true,
  );

  group('WeatherApp', () {
    testWidgets('renders WeatherApp', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
            overrides: [
              // override the previous value with the new object
              sharedPreferencesProvider.overrideWithValue(sharedPref),
            ],
            child: WeatherApp()),
      );
      expect(find.byType(WeatherApp), findsOneWidget);
    });
  });

  group('WeatherApp', () {
    testWidgets('renders WeatherPage', (tester) async {
      // when(() => themeCubit.state).thenReturn(Colors.blue);
      await tester.pumpWidget(ProviderScope(
        overrides: [
          // override the previous value with the new object
          sharedPreferencesProvider.overrideWithValue(sharedPref),
        ],
        child: WeatherApp(),
      ));
      expect(find.byType(WeatherPage), findsOneWidget);
    });

    testWidgets('has correct theme primary color', (tester) async {
      const color = Color(0xFFD2D2D2);
      // when(() => themeCubit.state).thenReturn(color);
      final focus = container.readProviderElement(themeState);
      focus.setState(color);
      await tester.pumpWidget(ProviderScope(
        overrides: [
          // override the previous value with the new object
          sharedPreferencesProvider.overrideWithValue(sharedPref),
        ],
        parent: container,
        child: const WeatherApp(),
      ));
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.primaryColor, color);
    });
  });
}
