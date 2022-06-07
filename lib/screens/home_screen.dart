import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/datas/promotion_news_json.dart';
import 'package:loyalty_platform_mobile_flutter/datas/promotion_point_json.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_promotion_news.dart';

import '../widgets/custom_functionbar.dart';
import '../widgets/custom_promotion_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/profilepicture.png'),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        "Hello ABC",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.purple[800],
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Silver Member ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple[800],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple,
                            Color.fromARGB(255, 222, 159, 233),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(10, 10),
                              blurRadius: 20,
                              color: Color.fromARGB(255, 222, 159, 233)
                                  .withOpacity(0.3),
                            )
                          ]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            "2000",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 4, bottom: 2),
                              child: Text(
                                'P',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: CustomFunctionBar(),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Text(
                    "Ưu đãi cho bạn",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5),
                child: Row(
                  children: List.generate(PromotionPointJson.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomPromotionPoint(
                        thumbNail: PromotionPointJson[index]['image'],
                        title: PromotionPointJson[index]['title'],
                        duration: PromotionPointJson[index]['duration'],
                        point: PromotionPointJson[index]['point'],
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Text(
                    "Xem gì hôm nay",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: List.generate(PromotionNewsJson.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                  child: CustomPromotionNew(
                    thumbNail: PromotionNewsJson[index]['image'],
                    title: PromotionNewsJson[index]['title'],
                  ),
                );
              }),
            )
          ],
        ),
      )),
    ));
  }
}
