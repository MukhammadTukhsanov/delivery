import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
  return isFirstLaunch;
}
