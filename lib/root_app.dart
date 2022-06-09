import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loyalty_platform_mobile_flutter/screens/home_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/notification_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        const HomeScreen(),
        const NotificationScreen(),
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
