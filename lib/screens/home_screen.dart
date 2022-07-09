// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/datas/image_promotion_json.dart';
import 'package:loyalty_platform_mobile_flutter/screens/promotion_news_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/promotion_point_voucher_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/services/promotion_services.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_appbar_homescreen.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_card_member.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_promotion_news.dart';
import 'package:marquee/marquee.dart';

import '../services/promotion_point_service.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: CustomAppBarHomeScreen(),
            collapsedHeight: 65,
            pinned: true,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            centerTitle: true,
          ),
          const SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomCardMembers(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
                          height: MediaQuery.of(context).size.width * .85,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (snapshot.data! as List).length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10, top: 10),
                                    child: CustomPromotionPoint(
                                      effectiveDate:
                                          (snapshot.data as List)[index]
                                              .effectiveDate,
                                      thumbNail: (snapshot.data as List)[index]
                                          .thumbNail,
                                      expirationDate:
                                          (snapshot.data as List)[index]
                                              .expirationDate,
                                      point: (snapshot.data as List)[index]
                                          .point
                                          .toString(),
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
                                      thumbNail:
                                          (snapshot.data as List)[index].imgUrl,
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
          ]))
        ],
      ),
    );
  }
}
