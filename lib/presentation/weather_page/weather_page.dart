import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  WeatherPage({super.key});
 // String city = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final state = ref.watch(weatherNotifier);
   //final city = ref.watch(cityProvider);
   // final state1 = ref.listen(weatherNotifier, (previous, next) {
   //   if(next.status == WeatherStatus.loading){
   //     next.weatherModels.;
   //   }
   // });
    String cityShared = sharedPref.getString('city');

   print('WeatherPage to city - $cityShared');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
              icon: const Icon(Icons.update),
              onPressed: () {
                String city = sharedPref.getString('city');
                if(city != ''){
                  ref.read(weatherNotifier.notifier).fetchWeather(city);
                }


              }
          ),
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage(),
                    ));
              }
          ),
        ],
      ),
      body: Center(
        //  child: Consumer(builder: (context, ref, child) {
child:Builder(builder: (BuildContext context) {
 // print('WeatherPage - Builder ${state.status}');
  final state = ref.watch(weatherNotifier);
  switch (state.status) {
    case WeatherStatus.initial:
    // if(city != ''){
    //   //state1.fetchWeather(city);
    //   return WeatherPopulatedNew(
    //     weatherModels: state.weatherModels,
    //     units: state.temperatureUnits,
    //     onRefresh: () async{
    //      // return await ref.read(weatherNotifier.notifier).refreshWeather();
    //     },
    //   );
    // }else{
      return  WeatherEmptyNew(weatherCondition: WeatherCondition.clear,);
  // }

    case WeatherStatus.loading:
      return const WeatherLoading();
    case WeatherStatus.success:
      return WeatherPopulatedNew(
        weatherModels: state.weatherModels,
        units: state.temperatureUnits,
        onRefresh: () async{
          // return await ref.read(weatherNotifier.notifier).refreshWeather();
        },
      );
    case WeatherStatus.failure:
      return const WeatherError();
  }
},)
           //state1.status;
//final state = ref.read(weatherNotifier.notifier).state;

            //ref.invalidate(weatherNotifier);
           // ref.refresh(provider)

            //final state = ref.watch(weatherNotifier.notifier).state;

          // final weather = state.weatherModels;
          // final color1 = ref.watch(themeState.notifier).updateTheme(weather);

           // print('weather_page_status: ${state.status}');



         // },)
        // BlocConsumer<WeatherCubit, WeatherState>(
        //   listener: (context, state) {
        //     if (state.status.isSuccess) {
        //       context.read<ThemeCubit>().updateTheme(state.weather);
        //     }
        //   },
        //   builder: (context, state) {
        //     switch (state.status) {
        //       case WeatherStatus.initial:
        //         return const WeatherEmpty();
        //       case WeatherStatus.loading:
        //         return const WeatherLoading();
        //       case WeatherStatus.success:
        //         return WeatherPopulated(
        //           weatherModels: state.weather,
        //           units: state.temperatureUnits,
        //           onRefresh: () {
        //            // return context.read<WeatherCubit>().refreshWeather();
        //           },
        //         );
        //       case WeatherStatus.failure:
        //         return const WeatherError();
        //     }
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage(),
              ));
          // final city = await Navigator.of(context).push(SearchPage.route());
          // if (!mounted) return;
          // await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}


// class WeatherPage extends ConsumerStatefulWidget {
//   const WeatherPage({super.key});
//
//   @override
//   _WeatherViewState createState() => _WeatherViewState();
// }
//
// class _WeatherViewState extends ConsumerState<WeatherPage> {
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Weather'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Navigator.of(context).push<void>(
//               //   SettingsPage.route(context.read<WeatherCubit>(),
//               //   ),
//               // );
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsPage(),
//               ));
//             }
//           ),
//         ],
//       ),
//       body: Center(
//         child: Consumer(builder: (context, ref, child) {
//          // final state = ref.watch(weatherNotifier.notifier).state;
//           final state = ref.watch(weatherNotifier.notifier).state;
//           print('weather_page_status: ${state.status}');
// // setState(() {
// //
// // });
//               switch (state.status) {
//                 case WeatherStatus.initial:
//                   return const WeatherEmpty();
//                 case WeatherStatus.loading:
//                   return const WeatherLoading();
//                 case WeatherStatus.success:
//                   return WeatherPopulated(
//                     weatherModels: state.weatherModels,
//                     units: state.temperatureUnits,
//                     //onRefresh: (){},
//                     // onRefresh: () {
//                     //  // return context.read<WeatherCubit>().refreshWeather();
//                     // },
//                   );
//                 case WeatherStatus.failure:
//                   return const WeatherError();
//               }
//         },)
//         // BlocConsumer<WeatherCubit, WeatherState>(
//         //   listener: (context, state) {
//         //     if (state.status.isSuccess) {
//         //       context.read<ThemeCubit>().updateTheme(state.weather);
//         //     }
//         //   },
//         //   builder: (context, state) {
//         //     switch (state.status) {
//         //       case WeatherStatus.initial:
//         //         return const WeatherEmpty();
//         //       case WeatherStatus.loading:
//         //         return const WeatherLoading();
//         //       case WeatherStatus.success:
//         //         return WeatherPopulated(
//         //           weatherModels: state.weather,
//         //           units: state.temperatureUnits,
//         //           onRefresh: () {
//         //            // return context.read<WeatherCubit>().refreshWeather();
//         //           },
//         //         );
//         //       case WeatherStatus.failure:
//         //         return const WeatherError();
//         //     }
//         //   },
//         // ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.search, semanticLabel: 'Search'),
//         onPressed: () async {
//           Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SearchPage(),
//               ));
//           // final city = await Navigator.of(context).push(SearchPage.route());
//           // if (!mounted) return;
//           // await context.read<WeatherCubit>().fetchWeather(city);
//         },
//       ),
//     );
//   }
// }
