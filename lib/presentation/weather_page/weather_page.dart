import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_riverpod_async/state/theme/theme_state.dart';
import '../../data/repository/model/models_repository.dart';
import '../../main.dart';
import '../../state/weather/weather_notifier.dart';
import '../../state/weather/weather_state.dart';
import '../search_page/search_page.dart';
import '../setting_page/settings_page.dart';
import 'widgets/weather_empty_new.dart';
import 'widgets/weather_error.dart';
import 'widgets/weather_loading.dart';
import 'widgets/weather_populated_new.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherNotifier);
    final themeColor = ref.watch(themeState);
    final weatherFuture = ref.watch(futureWeatherNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: themeColor.withOpacity(0.5),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.update),
              onPressed: () {
                String? city = sharedPref.getString('city');
                if (city != '') {
                  ref.read(weatherNotifier.notifier).fetchWeather(city);
                }
              }),
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              }),
        ],
      ),
      body: Center(
        child:
            //1. Use FutureBuilder
        // FutureBuilder(
        //   initialData: state,
        //   future: ref.read(futureWeatherNotifier.future),
        //   builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        //     // print('WeatherPage - Builder ${state.status}');
        //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
        //       // handle loading
        //       return const WeatherLoading();
        //     } else if (asyncSnapshot.hasData) {
        //       // handle data
        //       if (state.status == WeatherStatus.initial) {
        //         return WeatherEmptyNew(
        //           weatherCondition: WeatherCondition.clear,
        //         );
        //       } else {
        //         return WeatherPopulatedNew(
        //           weatherModels: state.weatherModels,
        //           units: state.temperatureUnits,
        //           onRefresh: () async {
        //             // return await ref.read(weatherNotifier.notifier).refreshWeather();
        //           },
        //         );
        //       }
        //     } else if (asyncSnapshot.hasError) {
        //       // handle error (note: snapshot.error has type [Object?])
        //       return const WeatherError();
        //     } else {
        //       // uh, oh, what goes here?
        //       return const Text('Some error occurred - welp!');
        //     }
        //   },
        // ),

          //2. AsyncValue
        weatherFuture.when(
            data: (data){
                    if (state.status == WeatherStatus.initial) {
                      return WeatherEmptyNew(
                        weatherCondition: WeatherCondition.clear,
                      );
                    } else {
                      return WeatherPopulatedNew(
                        weatherModels: state.weatherModels,
                        units: state.temperatureUnits,
                        onRefresh: () async {
                          // return await ref.read(weatherNotifier.notifier).refreshWeather();
                        },
                      );
                    }
            },
            error: (e, st){
              return const WeatherError();
            },
            loading: (){
              return const WeatherLoading();
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
      ),
    );
  }
}
