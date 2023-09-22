import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/app.dart';
import 'state/shared_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString('city') == null) {
    sharedPreferences.setString('city', '');
  }
  runApp(ProviderScope(overrides: [
    // override the previous value with the new object
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const WeatherApp()));
}
