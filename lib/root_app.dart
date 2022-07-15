// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loyalty_platform_mobile_flutter/screens/home_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/notification_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/profile_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/wallet_screen.dart';
import 'package:loyalty_platform_mobile_flutter/services/local_notification_service.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  // List<Widget> pages = const[
  //   HomeScreen(),
  //   WalletScreen(),
  //   NotificationScreen(),
  //   ProfileScreen(
  //     userDisplayName: 'Hoàng A',
  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      bottomNavigationBar: getFooter(),
      // body: pages[pageIndex],
      body: getBody(),
    );
  }

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.requestPermission().then((value) {
      print('abc ' + value.toString());
    });
    FirebaseMessaging.instance.getToken().then((token) {
      //print('DeviceToken: ' + token.toString());
    });
    FirebaseMessaging.instance.getAPNSToken().then((APNStoken) {
      print(APNStoken);
    });

    ///gives you the message on which user tap
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///when the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        HomeScreen(),
        WalletScreen(),
        NotificationScreen(),
        ProfileScreen(
          userDisplayName: 'Hoàng A',
        )
      ],
    );
  }

  Widget getFooter() {
    return SalomonBottomBar(
      currentIndex: pageIndex,
      onTap: (i) => setState(() => pageIndex = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Trang chủ"),
          selectedColor: Colors.purple,
        ),

        /// Wallet
        SalomonBottomBarItem(
          icon: const Icon(Icons.account_balance_wallet),
          title: const Text("Ví tiền"),
          selectedColor: Colors.purple,
        ),

        ///Notification
        SalomonBottomBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text("Thông báo"),
          selectedColor: Colors.purple,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: const Icon(Icons.person),
          title: const Text("Tài khoản"),
          selectedColor: Colors.purple,
        ),
      ],
    );
  }
}
