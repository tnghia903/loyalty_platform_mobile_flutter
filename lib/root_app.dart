import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/screens/home_screen.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        HomeScreen(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home_outlined,
      Icons.notifications_none_outlined,
      Icons.account_circle_outlined,
    ];
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 70,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 30,
            offset: Offset(0, -10))
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      items[index],
                      size: 32,
                      color: pageIndex == index
                          ? Colors.purple[500]
                          : Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    pageIndex == index
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              height: 5,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.purple[900],
                                  borderRadius: BorderRadius.circular(100)),
                            ))
                        : Container()
                  ],
                ),
              );
            })),
      ),
    );
  }
}
