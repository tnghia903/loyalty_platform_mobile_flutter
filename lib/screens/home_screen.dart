// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:loyalty_platform_mobile_flutter/screens/promotion_news_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/promotion_point_voucher_detail_screen.dart';
import 'package:loyalty_platform_mobile_flutter/services/member_tier_services.dart';
import 'package:loyalty_platform_mobile_flutter/services/membership_currency_services.dart';
import 'package:loyalty_platform_mobile_flutter/services/promotion_services.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_appbar_homescreen.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_card_member.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_promotion_news.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/promotion_point_service.dart';
import '../widgets/custom_functionbar.dart';
import '../widgets/custom_promotion_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? point;
String? tier;

class _HomeScreenState extends State<HomeScreen> {
  int _count = 0;

  void _update() {
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> updateScore() async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      List response = await Future.wait([
        MemberTierServices().getMemberTier(),
        MemberShipCurrencyService().getMemberShipCurrency(),
        // tier = response[0].name.toString();
        // point = response[1].pointsBalance.toString();
      ]);

      pref.setString('point', response[1].pointsBalance.toString());
      pref.setString('tier', response[0].name.toString());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          updateScore();
        });
      },
      child: Scaffold(
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
                                          right: 5,
                                          bottom: 10,
                                          top: 10,
                                          left: 5),
                                      child: CustomPromotionPoint(
                                        update: _update,
                                        id: (snapshot.data as List)[index].id,
                                        effectiveDate:
                                            (snapshot.data as List)[index]
                                                .effectiveDate,
                                        thumbNail:
                                            (snapshot.data as List)[index]
                                                .thumbNail,
                                        expirationDate:
                                            (snapshot.data as List)[index]
                                                .expirationDate,
                                        point: (snapshot.data as List)[index]
                                            .point
                                            .toString(),
                                        title: (snapshot.data as List)[index]
                                            .title,
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
                                            (snapshot.data as List)[index]
                                                .imgUrl,
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
                                            items:
                                                (snapshot.data as List)[index],
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
      ),
    );
  }
}
