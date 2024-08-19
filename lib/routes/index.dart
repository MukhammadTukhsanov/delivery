import 'package:flutter/material.dart';
import 'package:yolda/pages/onboarding/onboarding.dart';
import 'package:yolda/pages/registration/auth_page.dart';
import 'package:yolda/pages/registration/login.dart';
import 'package:yolda/pages/registration/registration.dart';
import 'package:yolda/pages/splash-screen/splash.dart';

class Routs extends StatelessWidget {
  const Routs({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/': (context) => const Splash(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration()
      },
    );
  }
}
