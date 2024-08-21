import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolda/pages/onboarding/onboarding.dart';
import 'package:yolda/pages/registration/auth_page.dart';
import 'package:yolda/pages/registration/login.dart';
import 'package:yolda/pages/registration/registration.dart';
import 'package:yolda/pages/splash-screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasSeenSplash = prefs.getBool('hasSeenSplash') ?? false;

  runApp(Routs(initialRoute: hasSeenSplash ? '/auth' : '/splash'));
}

class Routs extends StatelessWidget {
  final String initialRoute;

  const Routs({super.key, required this.initialRoute});

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/auth':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/registration':
        return MaterialPageRoute(builder: (_) => const Registration());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Page not found: ${settings.name}'),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      onGenerateRoute: _generateRoute,
    );
  }
}
