import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loyalty_platform_mobile_flutter/backgroundHandler.dart';
import 'package:loyalty_platform_mobile_flutter/firebase_options.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/screens/home_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/map_screen.dart';

import 'package:loyalty_platform_mobile_flutter/screens/notification_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<void> loginLoyaltyProgram() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse("http://13.232.213.53/api/v1/auth/login"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, String?>{
        'idToken': pref.getString('idTokenGoogle'),
        'deviceId': pref.getString('deviceId'),
      },
    ),
  );
  if (response.statusCode == 200) {
    print('response login ne: ${jsonDecode(response.body)}');
    String accessToken = jsonDecode(response.body)['token'];
    pref.setString('accessToken', accessToken);
    int accountId = jsonDecode(response.body)['accountId'];
    pref.setString('accountId', accountId.toString());
    String point = jsonDecode(response.body)['point'].toString();
    pref.setString('point', point);
    String tier = jsonDecode(response.body)['tier'];
    pref.setString('tier', tier.toString());
  } else {
    print('hong co duoc: ${jsonDecode(response.body)}');
  }
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
        // "notification": (_) => const NotificationScreen(),
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
            loginLoyaltyProgram();
            return const RootApp();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
      // RootApp(),
      // home: const MapScreen(),
    );
  }
}
