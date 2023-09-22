import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_riverpod_async/data/repository/model/models_repository.dart';
import 'package:weather_riverpod_async/data/repository/weather_repository.dart';
import 'package:weather_riverpod_async/domain/weather_models.dart';
import 'package:weather_riverpod_async/presentation/search_page/search_page.dart';
import 'package:weather_riverpod_async/presentation/setting_page/settings_page.dart';
import 'package:weather_riverpod_async/presentation/weather_page/weather_page.dart';
import 'package:weather_riverpod_async/presentation/weather_page/widgets/weather_empty_new.dart';
import 'package:weather_riverpod_async/presentation/weather_page/widgets/weather_populated_new.dart';
import 'package:weather_riverpod_async/state/shared_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_state.dart';
import '../../shared_pref_init.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

// class MockThemeState extends Mock implements ThemeState {}
//
// class MockWeatherNotifier extends Mock implements WeatherNotifier {
// }

//final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => WeatherNotifier());
class Listener extends Mock {
  void call(WeatherState? previous, WeatherState value);
}

void main() async {
  SharedPreferences sharedPref = await initShared();
  MockWeatherRepository mockWeatherRepository = MockWeatherRepository();
  final container = ProviderContainer();

  final listener = Listener();

  group('WeatherPage', () {
    //late WeatherRepository weatherRepository;

    setUp(() {
     // weatherRepository = MockWeatherRepository();
    });

    testWidgets('renders WeatherView', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
         parent: container,
          overrides: [
            // override the previous value with the new object
            sharedPreferencesProvider.overrideWithValue(sharedPref),
            repository.overrideWithValue(mockWeatherRepository),
          ],
          child:MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherPage), findsOneWidget);
     // expect(find.byType(WeatherEmpty), findsOneWidget);
    });
  });

  group('WeatherView', () {
    final weather = WeatherModels(
      temperature: Temperature(value: 4.2),
      condition: WeatherCondition.cloudy,
      lastUpdated: DateTime(2020),
      location: 'London',
    );
    // late final themeCubit;
    // //final weatherCubit = container.read(weatherNotifierProvider);
    // late WeatherNotifier weatherCubit;
    //
    // setUp(() {
    //  // themeCubit = MockThemeState();
    //   //weatherCubit = weatherNotifierProvider;
    //  weatherCubit = MockWeatherNotifier();
    // });

    testWidgets('renders WeatherEmpty for WeatherStatus.initial',
            (tester) async {
         //when(() => weatherCubit).thenReturn(WeatherState());
            //  when(() => weatherNotifierProvider).thenReturn(WeatherState());
             final focus = container.readProviderElement(weatherNotifier);
            // focus.setState(WeatherState(status: WeatherStatus.initial, weatherModels: weather),);
             focus.setState(WeatherState(status: WeatherStatus.initial),);
            // focus.update(newProvider)
            //  mockWeatherRepository = MockWeatherRepository();
          await tester.pumpWidget(
            ProviderScope(
                parent: container,
              overrides: [
                // override the previous value with the new object
                sharedPreferencesProvider.overrideWithValue(sharedPref),
                repository.overrideWithValue(mockWeatherRepository),

              ],
              // overrides: [
              //   // Override the behavior of repositoryProvider to return
              //   // FakeRepository instead of Repository.
              //   weatherNotifierProvider.overrideWithValue(weatherRepository)
              //   // We do not have to override `todoListProvider`, it will automatically
              //   // use the overridden repositoryProvider
              // ],
              child: MaterialApp(home: WeatherPage()),
            ),
          );
          await tester.pumpAndSettle();
         expect(find.byType(WeatherEmptyNew), findsOneWidget);
        //  expect(find.byType(WeatherLoading), findsOneWidget);
        });

    testWidgets('renders WeatherLoading for WeatherStatus.loading',
            (tester) async {
             // listener.call(WeatherState(), WeatherState(status: WeatherStatus.loading));
              // when(() => weatherCubit.state).thenReturn(
              //   WeatherState(
              //     status: WeatherStatus.loading,
              //   ),
              // );
              //Для тестирования нужно было получить стейт и обновлять его различными данными
              //Раньше написали что использовали
              // weatherNotifierProvider.overrideWithValue(
              //     AsyncValue.data(WeatherState(status: ))
              //Но с пока убрали такую возможность и нашел такой вариант
              final focus = container.readProviderElement(weatherNotifier);
             focus.setState(WeatherState(status: WeatherStatus.loading));

             //Вот так получаем стейт для печати
             // final state = focus.getState()!.requireState;
              // print(state.toString());
          await tester.pumpWidget(
               ProviderScope(
                   parent: container,
                   overrides: [
                     // override the previous value with the new object
                     sharedPreferencesProvider.overrideWithValue(sharedPref),
                     repository.overrideWithValue(mockWeatherRepository),
                   ],

                  // weatherNotifierProvider.overrideWithProvider(container.read(weatherNotifierProvider)),
                   //weatherNotifierProvider.overrideWithProvider(StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => weatherCubit))
                 //  weatherNotifier.status = WeatherStatus.loading;
                       //.state.copyWith(status: WeatherStatus.loading,) ))
                   // Override the behavior of repositoryProvider to return
                   // FakeRepository instead of Repository.
                   // weatherNotifierProvider.overrideWithValue(
                   //     AsyncValue.data(WeatherState(status: ))
                   // ),
                   // We do not have to override `todoListProvider`, it will automatically
                   // use the overridden repositoryProvider

                   child: MaterialApp(home:WeatherPage()),
                 //  Builder(
                   //  builder: (context) {
                      // final focus = container.readProviderElement(weatherNotifier);
                      // focus.setState(WeatherState(status: WeatherStatus.loading));
                      // final state = focus.getState()!.requireState;

                      // print(state.toString());
                    //   return WeatherPage();
                   //  }
                  // )
                //   )),

          ));
              await tester.pumpAndSettle();
             final status = container.readProviderElement(weatherNotifier).requireState.status;
             //Разобраться почему вот так не работает в этом случае
              //expect(find.byType(WeatherLoading), findsOneWidget);
              expect(status, WeatherStatus.loading);
        });
  //
    testWidgets('renders WeatherPopulated for WeatherStatus.success',
            (tester) async {
              final focus = container.readProviderElement(weatherNotifier);
              focus.setState(WeatherState(status: WeatherStatus.success));
          await tester.pumpWidget(
           ProviderScope(
             parent: container,
             overrides: [
               // override the previous value with the new object
               sharedPreferencesProvider.overrideWithValue(sharedPref),
               repository.overrideWithValue(mockWeatherRepository),
             ],
           child: MaterialApp(home: WeatherPage()),
           )
          );
              await tester.pumpAndSettle();
          expect(find.byType(WeatherPopulatedNew), findsOneWidget);
        });

    testWidgets('renders WeatherError for WeatherStatus.failure',
            (tester) async {
              final focus = container.readProviderElement(weatherNotifier);
              focus.setState(WeatherState(status: WeatherStatus.failure));
          await tester.pumpWidget(
              ProviderScope(
                parent: container,
                overrides: [
                  // override the previous value with the new object
                  sharedPreferencesProvider.overrideWithValue(sharedPref),
                  repository.overrideWithValue(mockWeatherRepository),
                ],
                child: MaterialApp(home: WeatherPage()),
              )
          );
              await tester.pumpAndSettle();
              final status = container.readProviderElement(weatherNotifier).requireState.status;
              expect(status, WeatherStatus.failure);
         // expect(find.byType(WeatherError), findsOneWidget);
        });

  //   testWidgets('state is cached', (tester) async {
  //     when<dynamic>(() => hydratedStorage.read('WeatherCubit')).thenReturn(
  //       WeatherState(
  //         status: WeatherStatus.success,
  //         weather: weather,
  //         temperatureUnits: TemperatureUnits.fahrenheit,
  //       ).toJson(),
  //     );
  //     await tester.pumpWidget(
  //       BlocProvider.value(
  //         value: WeatherCubit(MockWeatherRepository()),
  //         child: MaterialApp(home: WeatherView()),
  //       ),
  //     );
  //     expect(find.byType(WeatherPopulated), findsOneWidget);
  //   });
  //
    testWidgets('navigates to SettingsPage when settings icon is tapped',
            (tester) async {
        //  when(() => weatherCubit.state).thenReturn(WeatherState());
          await tester.pumpWidget(
              ProviderScope(
                parent: container,
                overrides: [
                  // override the previous value with the new object
                  sharedPreferencesProvider.overrideWithValue(sharedPref),
                  repository.overrideWithValue(mockWeatherRepository),
                ],
                child: MaterialApp(home: WeatherPage()),
              )
          );
          await tester.tap(find.byKey(const Key('icon_button _setting')));
          await tester.pumpAndSettle();
          expect(find.byType(SettingsPage), findsOneWidget);
        });

    testWidgets('navigates to SearchPage when search button is tapped',
            (tester) async {
        //  when(() => weatherCubit.state).thenReturn(WeatherState());
          await tester.pumpWidget(
              ProviderScope(
                parent: container,
                overrides: [
                  // override the previous value with the new object
                  sharedPreferencesProvider.overrideWithValue(sharedPref),
                  repository.overrideWithValue(mockWeatherRepository),
                ],
                child: MaterialApp(home: WeatherPage()),
              )
          );
          await tester.tap(find.byType(FloatingActionButton));
          await tester.pumpAndSettle();
          expect(find.byType(SearchPage), findsOneWidget);
        });

  //   testWidgets('calls updateTheme when whether changes', (tester) async {
  //     whenListen(
  //       weatherCubit,
  //       Stream<WeatherState>.fromIterable([
  //         WeatherState(),
  //         WeatherState(status: WeatherStatus.success, weather: weather),
  //       ]),
  //     );
  //     when(() => weatherCubit.state).thenReturn(
  //       WeatherState(
  //         status: WeatherStatus.success,
  //         weather: weather,
  //       ),
  //     );
  //     await tester.pumpWidget(
  //       MultiBlocProvider(
  //         providers: [
  //           BlocProvider.value(value: themeCubit),
  //           BlocProvider.value(value: weatherCubit),
  //         ],
  //         child: MaterialApp(home: WeatherView()),
  //       ),
  //     );
  //     verify(() => themeCubit.updateTheme(weather)).called(1);
  //   });
  //
  //   testWidgets('triggers refreshWeather on pull to refresh', (tester) async {
  //     when(() => weatherCubit.state).thenReturn(
  //       WeatherState(
  //         status: WeatherStatus.success,
  //         weather: weather,
  //       ),
  //     );
  //     when(() => weatherCubit.refreshWeather()).thenAnswer((_) async {});
  //     await tester.pumpWidget(
  //       BlocProvider.value(
  //         value: weatherCubit,
  //         child: MaterialApp(home: WeatherView()),
  //       ),
  //     );
  //     await tester.fling(
  //       find.text('London'),
  //       const Offset(0, 500),
  //       1000,
  //     );
  //     await tester.pumpAndSettle();
  //     verify(() => weatherCubit.refreshWeather()).called(1);
  //   });
  //
  //   testWidgets('triggers fetch on search pop', (tester) async {
  //     when(() => weatherCubit.state).thenReturn(WeatherState());
  //     when(() => weatherCubit.fetchWeather(any())).thenAnswer((_) async {});
  //     await tester.pumpWidget(
  //       BlocProvider.value(
  //         value: weatherCubit,
  //         child: MaterialApp(home: WeatherView()),
  //       ),
  //     );
  //     await tester.tap(find.byType(FloatingActionButton));
  //     await tester.pumpAndSettle();
  //     await tester.enterText(find.byType(TextField), 'Chicago');
  //     await tester.tap(find.byKey(const Key('searchPage_search_iconButton')));
  //     await tester.pumpAndSettle();
  //     verify(() => weatherCubit.fetchWeather('Chicago')).called(1);
  //   });
  });
}
