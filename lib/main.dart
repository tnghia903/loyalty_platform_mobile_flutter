import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/backgroundHandler.dart';
import 'package:loyalty_platform_mobile_flutter/firebase_options.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/screens/home_screen.dart';

import 'package:loyalty_platform_mobile_flutter/screens/notification_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loyalty platform app',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        "notification": (_) => const NotificationScreen(),
        "root": (_) => const RootApp(),
      },

      //WelcomeScreen(),

      // home: isSignedIn ? const HomeScreen() : const WelcomeScreen(),
      // home: RootApp(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong. Please try again later'),
            );
          } else if (snapshot.hasData) {
            return const RootApp();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
      // RootApp(),
    );
  }
}
