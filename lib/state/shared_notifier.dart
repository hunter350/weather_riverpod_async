import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> initSharedPref() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString('city') == null) {
    await sharedPreferences.setString('city', '');
  }
  return sharedPreferences;
}


final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
