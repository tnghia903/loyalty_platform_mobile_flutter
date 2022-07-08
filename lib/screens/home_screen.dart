// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/datas/image_promotion_json.dart';
import 'package:loyalty_platform_mobile_flutter/datas/promotion_point_json.dart';
import 'package:loyalty_platform_mobile_flutter/screens/promotion_news_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/promotion_point_voucher_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/services/promotion_services.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_promotion_news.dart';

import '../services/promotion_point_service.dart';
import '../widgets/custom_functionbar.dart';
import '../widgets/custom_promotion_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final name = user?.displayName;
final avatarUrl = user?.photoURL;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Row(
                children: [
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(avatarUrl!),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Text(
                          name!,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.purple[800],
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 4, bottom: 2, top: 2, right: 4),
                          child: Text(
                            "Thành viên bạc",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 44, 33, 58),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.purple,
                            Color.fromARGB(255, 222, 159, 233),
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(17)),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(10, 10),
                              blurRadius: 20,
                              color: const Color.fromARGB(255, 222, 159, 233)
                                  .withOpacity(0.3),
                            )
                          ]),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 17,
                          ),
                          const Text(
                            "2000",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(left: 8, top: 4, bottom: 2),
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
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: CustomFunctionBar(),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
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
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: PromotionVoucherService().getPromotionVoucher(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return snapshot.hasData
                      ? SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: (snapshot.data! as List).length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CustomPromotionPoint(
                                      effectiveDate:
                                          (snapshot.data as List)[index]
                                              .effectiveDate,
                                      thumbNail: (snapshot.data as List)[index]
                                          .thumbNail,
                                      expirationDate:
                                          (snapshot.data as List)[index]
                                              .expirationDate,
                                      point: '0',
                                      title:
                                          (snapshot.data as List)[index].title,
                                    ),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        builder: (context) =>
                                            PromotionPointVoucherDetailScreen(
                                                items: (snapshot.data
                                                    as List)[index]));
                                  });
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                }),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
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
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: PromotionService().getPromotion(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return snapshot.hasData
                      ? SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (snapshot.data! as List).length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20),
                                    child: CustomPromotionNew(
                                      thumbNail: getImage()[index].image,
                                      title: (snapshot.data as List)[index]
                                          .promotionName,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PromotionNewsDetailScreen(
                                          items: (snapshot.data as List)[index],
                                          imagePromotion: getImage()[index],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })
          ],
        ),
      ),
    ));
  }
}
