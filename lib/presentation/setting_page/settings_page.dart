import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_riverpod_async/domain/weather_models.dart';

import '../../state/weather/weather_notifier.dart';


//class SettingsPage extends StatelessWidget {
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  //const SettingsPage._();

  // static Route<void> route(WeatherCubit weatherCubit) {
  //   return MaterialPageRoute<void>(
  //     builder: (_) => BlocProvider.value(
  //       value: weatherCubit,
  //       child: const SettingsPage._(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeStateSetting = ref.watch(themeState);
    final weatherNotifierIsCels = ref.watch(weatherNotifier);
    //final weatherNotifierIsCels = ref.read(weatherNotifier.notifier).state;
   // print('SettingPage status - ${weatherNotifierIsCels.status}');

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Temperature Units'),
            isThreeLine: true,
            subtitle: const Text(
              'Use metric measurements for temperature units.',
            ),
            trailing: Switch(
                //value: state.temperatureUnits.isCelsius,
                //Отслеживаем изменение Цельсии - Фаренгейт
                value: weatherNotifierIsCels.temperatureUnits.isCelsius,
                //state.temperatureUnits.isCelsius,
                // onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
                //Изменеям Цельсии в Фаренгейт
                onChanged: (_) async{
                  final weather = ref.read(weatherNotifier.notifier);
                  weather.toggleUnits();
                 // weather.state.copyWith(status: WeatherStatus.success);
                 //  String city = sharedPref.getString('city');
                 //  //print('SettingPage status - ${weather.state.status}');
                 //  print('SettingPage city - $city');
                  // weather.refreshWeather();
                }),
          )
          //},
          //  ),
          // BlocBuilder<WeatherCubit, WeatherState>(
          //   buildWhen: (previous, current) =>
          //   previous.temperatureUnits != current.temperatureUnits,
          //   builder: (context, state) {
          //     return ListTile(
          //       title: const Text('Temperature Units'),
          //       isThreeLine: true,
          //       subtitle: const Text(
          //         'Use metric measurements for temperature units.',
          //       ),
          //       trailing: Switch(
          //         value: state.temperatureUnits.isCelsius,
          //         onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
