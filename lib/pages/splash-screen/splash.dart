import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolda/pages/onboarding/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool hasSeenSplash = prefs.getBool('hasSeenSplash') ?? false;

    if (!hasSeenSplash) {
      await prefs.setBool('hasSeenSplash', true);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isNavigating) {
          setState(() => _isNavigating = true);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const OnboardingPage()),
              (Route<dynamic> route) => false);
        }
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isNavigating) {
          setState(() => _isNavigating = true);
          Navigator.pushReplacementNamed(context, '/auth');
        }
      });
    }
  }

  @override
  void dispose() {
    _isNavigating = true; // Prevent any further navigation or operations
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffff9556),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: Image(
            image: AssetImage('assets/img/logo_white.png'),
          ),
        ),
      ),
    );
  }
}
