import 'package:flutter/material.dart';
import 'package:yolda/controllers/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: TextButton(onPressed: AuthService.logout, child: Text("logout")),
      ),
    );
  }
}
