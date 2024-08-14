import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:yolda/pages/onboarding/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OnboardingPage()),
            ModalRoute.withName('onboarding/'));
      });
    });
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
