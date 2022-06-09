import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loyalty_platform_mobile_flutter/datas/notification_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.purple[400],
          title: const Text(
            'Thông Báo',
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor:
          const Color.fromARGB(255, 222, 159, 233).withOpacity(0.2),
      body: getBody(),
    ));
  }

  Widget getBody() {
    final Notification items;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: List.generate(getNotification().length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 360,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: Image.asset(
                            getNotification()[index].icon,
                            scale: 4,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    getNotification()[index]
                                        .tilte
                                        .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text(
                                    getNotification()[index].datetime,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                getNotification()[index].description,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          })),
        ),
      ),
    );
  }
}
