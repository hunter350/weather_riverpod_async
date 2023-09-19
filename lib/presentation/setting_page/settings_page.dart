import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_riverpod_async/domain/weather_models.dart';

import '../../state/weather/weather_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherNotifierIsCels = ref.watch(weatherNotifier);

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
                //Изменеям Цельсии в Фаренгейт
                onChanged: (_) async {
                  final weather = ref.read(weatherNotifier.notifier);
                  weather.toggleUnits();
                }),
          ),
        ],
      ),
    );
  }
}
