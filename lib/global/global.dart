import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
  return isFirstLaunch;
}

String formatNumber(double number) {
  // Convert to string without decimal places
  String numberString = number.toStringAsFixed(0);
  StringBuffer result = StringBuffer();
  int count = 0;

  // Loop through the string in reverse
  for (int i = numberString.length - 1; i >= 0; i--) {
    count++;
    result.write(numberString[i]);
    // Add a space every 3 digits
    if (count % 3 == 0 && i != 0) {
      result.write(' ');
    }
  }

  // Reverse the result to get the correct format
  return result.toString().split('').reversed.join('');
}
