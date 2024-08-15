import 'package:flutter/material.dart';
import 'package:yolda/pages/onboarding/onboarding.dart';
import 'package:yolda/pages/registration/registrarion.dart';
import 'package:yolda/pages/splash-screen/splash.dart';

class Routs extends StatelessWidget {
  const Routs({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Splash(),
        '/onboarding': (context) => const OnboardingPage(),
        '/registration': (context) => const Registration()
      },
    );
  }
}
