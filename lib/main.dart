import 'package:calculator_app/pages/homepage.dart';
import 'package:calculator_app/pages/utils/settingspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      routes: {
        '/settingspage' :(context) => Settingspage()
      },
    );
  }
}