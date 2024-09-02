import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(height: 24),
              Text(
                'Internet aloqasi yo\'q',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Iltimos, internet aloqangizni tekshiring va qaytadan urinib ko\'ring.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Qayta urinib ko'rish
                },
                child: Text('Qayta urinib ko\'rish'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Sozlamalarga o'tish
                },
                child: Text('Sozlamalarga o\'tish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
