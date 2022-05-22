import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Loyalty platform app',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
