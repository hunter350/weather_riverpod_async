import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/app.dart';


late final SharedPreferences sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.getString('city') == null) {
    sharedPref.setString('city', '');
    //style = 'first';
  }
  runApp(const ProviderScope(child: WeatherApp()));
}