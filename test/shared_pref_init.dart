import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> initShared()async{
  await TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({'city': ''});
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return sharedPref;
}