import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loyalty_platform_mobile_flutter/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // List<bool> isSelected = List.generate(50, (index) => false);
  Color colorContainer = const Color.fromARGB(255, 232, 197, 238);
  Future<void> changeisRead(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    await http.put(Uri.parse("http://13.232.213.53/api/v1/notification/$id"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
  }

  String splitString(String data) {
    var dataarray = data.split("/");
    var datastring = '${dataarray[2]}/${dataarray[1]}';
    return datastring;
  }

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   setState(() {
    //     // _messages = [..._messages, message];
    //   });
    // });
    setState(() {
      NotificationService().getNoti().asStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: NotificationService().getNoti().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SafeArea(
                  child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
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
                      backgroundColor: Colors.white,
                      body: RefreshIndicator(
                        onRefresh: () {
                          setState(() {
                            NotificationService().getNoti().asStream();
                          });
                          return changeisRead(0);
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          itemCount: (snapshot.data!).length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  changeisRead(
                                      (snapshot.data as List)[index].id);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, left: 5, bottom: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: (snapshot.data as List)[index]
                                                  .isRead ==
                                              true
                                          ? Colors.white
                                          : colorContainer,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .63,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          (snapshot.data as List)[
                                                                      index]
                                                                  .tilte ??
                                                              'N/D'
                                                                  .toUpperCase(),
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        splitString((snapshot
                                                                    .data
                                                                as List)[index]
                                                            .datetime),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .6,
                                                  child: Text(
                                                    (snapshot.data
                                                                as List)[index]
                                                            .description ??
                                                        'N/D',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      )))
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  // Widget getBody() {
  //   if (_messages.isEmpty) {
  //     return const Center(child: Text('No notification received'));
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           children: List.generate(
  //             _messages.length,
  //             (index) {
  //               RemoteMessage message = _messages[_messages.length - 1 - index];

  //               DateTime? time = message.sentTime;

  //               return GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     isSelected[index] = true;
  //                   });
  //                 },
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.only(right: 5, left: 5, bottom: 15),
  //                   child: Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: MediaQuery.of(context).size.width * 0.3,
  //                     decoration: BoxDecoration(
  //                         color: isSelected[index] == true
  //                             ? Colors.white
  //                             : colorContainer,
  //                         boxShadow: [
  //                           BoxShadow(
  //                             spreadRadius: 1,
  //                             blurRadius: 5,
  //                             color: Colors.black.withOpacity(0.3),
  //                           ),
  //                         ],
  //                         border: Border.all(
  //                           color: Colors.black.withOpacity(0.2),
  //                           width: 0.1,
  //                         ),
  //                         borderRadius: BorderRadius.circular(15)),
  //                     child: Padding(
  //                         padding: const EdgeInsets.all(10.0),
  //                         child: Row(
  //                           children: [
  //                             Image.asset(
  //                               'assets/images/IconNotification.png',
  //                               scale: 4,
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                 top: 15,
  //                                 left: 10,
  //                               ),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     width: MediaQuery.of(context).size.width *
  //                                         .63,
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Expanded(
  //                                           child: Text(
  //                                             message.notification?.title ??
  //                                                 'N/D'.toUpperCase(),
  //                                             softWrap: false,
  //                                             overflow: TextOverflow.ellipsis,
  //                                             maxLines: 1,
  //                                             style: const TextStyle(
  //                                                 fontSize: 15,
  //                                                 color: Colors.black,
  //                                                 fontWeight: FontWeight.bold),
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           DateFormat("dd/MM hh:mm aaa")
  //                                               .format(time!),
  //                                           // time!.toString(),
  //                                           overflow: TextOverflow.clip,
  //                                           style: const TextStyle(
  //                                               fontSize: 12,
  //                                               color: Colors.black),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   const SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   SizedBox(
  //                                     width: MediaQuery.of(context).size.width *
  //                                         .6,
  //                                     child: Text(
  //                                       message.notification?.body ?? 'N/D',
  //                                       overflow: TextOverflow.ellipsis,
  //                                       maxLines: 2,
  //                                       style: const TextStyle(
  //                                           fontSize: 15, color: Colors.black),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         )),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
