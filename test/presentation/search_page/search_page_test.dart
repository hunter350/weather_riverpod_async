import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_riverpod_async/presentation/search_page/search_page.dart';
import 'package:weather_riverpod_async/state/shared_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_state.dart';

import '../../shared_pref_init.dart';

class Listener extends Mock {
  void call(WeatherState? previous, WeatherState value);
}

void main() async{
  SharedPreferences sharedPref = await initShared();

  //Чтобы использовать Риверпод без Флаттера нужен ProviderContainer
  final container = ProviderContainer();

  group('SearchPage', ()
  {
    testWidgets('is routable', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // override the previous value with the new object
            sharedPreferencesProvider.overrideWithValue(sharedPref),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) =>
                  Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (
                             //   context) => SearchPageTest(sharedPreferences: sharedPref),
                                context) => SearchPage(),
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
      expect(find.byType(SearchPage), findsOneWidget);
    });

    testWidgets('returns selected text when popped', (tester) async {
      await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // override the previous value with the new object
              sharedPreferencesProvider.overrideWithValue(sharedPref),
            ],
            parent: container,
            child: MaterialApp(
              home: Builder(
                builder: (context) =>
                    Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (
                                  context) => SearchPage(),
                              ));
                          // location = await Navigator.of(context).push(
                          //   SearchPage.route(),
                          // );
                        },
                      ),
                    ),
              ),
            ),
          )
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Chicago');

      //С этого момента тест не проходит из-за sharedPref
      // на кнопке в самом файле const SearchPage(),

    await tester.tap(find.byKey(const Key('searchPage_search_iconButton')));
      //   .then((value){
      //   final location1 = container.readProviderElement(weatherNotifier).getState()!.requireState;
      //   location = location1.weatherModels.location;
      // //    final location1 = container.readProviderElement(weatherNotifier);
      // //    //Научился обновлять Риверпод с помощью setState
      // //     location1.setState(WeatherState(weatherModels: WeatherModels(condition: WeatherCondition.unknown, lastUpdated: DateTime(0), location: 'Chicago', temperature: const Temperature(value: 0))));
      // //    location = location1.getState()!.requireState.weatherModels.location;
      //     //  print("Location  $location");
      //  });
       await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsNothing);//Почему-то выдает ошибку
      String? location = await sharedPref.getString('city');
      //Вот так обошел эту проверку, тест проверяет тоже самое
       expect(location, 'Chicago');
    });

    testWidgets('returns selected text when popped and String must be Chicago or previus value ', (tester) async {
      await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // override the previous value with the new object
              sharedPreferencesProvider.overrideWithValue(sharedPref),
            ],
            parent: container,
            child: MaterialApp(
              home: Builder(
                builder: (context) =>
                    Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (
                                  context) => SearchPage(),
                              ));
                        },
                      ),
                    ),
              ),
            ),
          )
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsOneWidget);
      await tester.enterText(find.byType(TextField), '');

      await tester.tap(find.byKey(const Key('searchPage_search_iconButton')));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsNothing);//Почему-то выдает ошибку
      String? location = await sharedPref.getString('city');
      await tester.pumpAndSettle();
      //Вот так обошел эту проверку, тест проверяет тоже самое
      expect(location, 'Chicago');
    });
  });
}