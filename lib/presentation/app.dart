import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../state/theme/theme_state.dart';
import '../state/weather/weather_notifier.dart';
import 'weather_page/weather_page.dart';


String cityFromShared = sharedPref.getString('city');

class WeatherApp extends ConsumerStatefulWidget {
  const WeatherApp({super.key});

  @override
  ConsumerState<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends ConsumerState<WeatherApp> {
 //  String city = '';
 // //
 // @override
 //  void didChangeDependencies() async{
 //   if(sharedPref.getString('city') != ''){
 //     // state.copyWith (status: WeatherStatus.success );
 //    // print('WeatherPage to ${state.status}');
 //     city = sharedPref.getString('city');
 //     // String city = sharedPref.getString('city');
 //     final state = ref.read(weatherNotifier.notifier);
 //     await state.fetchWeather(city);
 //   }
 //   setState(() {
 //
 //   });
 //    super.didChangeDependencies();
 //  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = ref.watch(themeState);
    //final state = ref.watch(weatherNotifier);
    // final color = ref.read(themeState.notifier).state;//Тему вот здесь меняю

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color,
        textTheme: GoogleFonts.rajdhaniTextTheme(),
        appBarTheme: AppBarTheme(
          color: color, //Здесь меняем тему шапки
          titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme)
              .apply(bodyColor: Colors.white)
              .headline6,
        ),
      ),
      home: WeatherPage(),
    );
  }
}

final cityProvider = FutureProvider((ref) {
  if(cityFromShared != ''){
    ref.read(weatherNotifier.notifier).fetchWeather(cityFromShared);
  }
});