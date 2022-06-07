import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.purple[400],
          title: Text(
            'Thông Báo',
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: getBody(),
    ));
  }

  Widget getBody() {
    List items = [
      'Ưu đãi cực sốc với chương trình giảm giá lên đến 60%',
      'Ưu đãi cực sốc với chương trình giảm giá lên đến 60%',
      'Ưu đãi cực sốc với chương trình giảm giá lên đến 60%',
      'Ưu đãi cực sốc với chương trình giảm giá lên đến 60%',
      'Ưu đãi cực sốc với chương trình giảm giá lên đến 60%',
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 380,
          height: 700,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 100,
                color: Color.fromARGB(255, 222, 159, 233).withOpacity(0.7),
              )
            ],
            border:
                Border.all(color: Colors.black.withOpacity(0.2), width: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: List.generate(items.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 360,
                    height: 120,
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
                      child: Text(
                        items[index],
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                );
              })),
            ),
          )),
    );
  }
}
