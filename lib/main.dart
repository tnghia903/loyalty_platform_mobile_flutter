import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/backgroundHandler.dart';
import 'package:loyalty_platform_mobile_flutter/firebase_options.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/screens/notification_screen.dart';

import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';
import 'package:loyalty_platform_mobile_flutter/services/geolocator_services.dart';
import 'package:provider/provider.dart';

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

class _MyAppState extends State<MyApp> {
  final locatorService = GeolocatorService();
  static const bool isSignedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => locatorService.getLocation(),
      initialData: null,
      child: MaterialApp(
        title: 'Loyalty platform app',
        debugShowCheckedModeBanner: false,

        routes: {
          "notification": (_) => const NotificationScreen(),
          "root": (_) => const RootApp(),
        },

        //WelcomeScreen(),
        home: isSignedIn ? const RootApp() : const WelcomeScreen(),

        // RootApp(),
      ),
    );
  }
}
