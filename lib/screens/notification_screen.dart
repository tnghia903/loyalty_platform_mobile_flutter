import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loyalty_platform_mobile_flutter/datas/notification_data.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.checklist_rounded,
                    size: 30,
                  )),
            )
          ],
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
    if (_messages.isEmpty) {
      return const Center(child: Text('No notification received'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: List.generate(
              _messages.length,
              (index) {
                RemoteMessage message = _messages[_messages.length - 1 - index];
                DateTime? time = message.sentTime;
                return Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5, bottom: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.3,
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/IconNotification.png',
                              scale: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .63,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            message.notification?.title ??
                                                'N/D'.toUpperCase(),
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          DateFormat("dd/MM").format(time!),
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: Text(
                                      message.notification?.body ?? 'N/D',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
