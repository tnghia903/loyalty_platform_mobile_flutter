import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/firebase_options.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const bool isSignedIn = false;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Loyalty platform app',
      debugShowCheckedModeBanner: false,
      home: isSignedIn ? RootApp() : WelcomeScreen(),
      // RootApp(),
    );
  }
}
