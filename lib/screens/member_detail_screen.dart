import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loyalty_platform_mobile_flutter/object/membershipcurrency.dart';
import 'package:loyalty_platform_mobile_flutter/services/membership_currency_services.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_tier_detail_information.dart';
import 'package:primary_secondary_progress_bar/primary_secondary_progress_bar.dart';

class MemberDetailScreen extends StatefulWidget {
  const MemberDetailScreen({super.key});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

checkTextColors(int point, String text) {
  if (text == 'Tier 1') {
    if (point >= 0 && point <= 300) {
      return Colors.purple;
    } else {
      return Colors.black;
    }
  } else if (text == 'Tier 2') {
    if (point >= 301 && point <= 500) {
      return Colors.purple;
    } else {
      return Colors.black;
    }
  } else if (text == 'Tier 3') {
    if (point >= 501 && point <= 1000) {
      return Colors.purple;
    } else {
      return Colors.black;
    }
  } else if (text == 'Tier 4') {
    if (point >= 1001 && point <= 2000) {
      return Colors.purple;
    } else {
      return Colors.black;
    }
  } else {
    if (point >= 2001) {
      return Colors.purple;
    } else {
      return Colors.black;
    }
  }
}

checkPoint(double point) {
  if (point > 2000) {
    return 1.toDouble();
  } else {
    return ((point * 100) / 2000) / 100;
  }
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Thông tin chi tiết'),
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Container(
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: FutureBuilder(
                  future: MemberShipCurrencyService().getMemberShipCurrency(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // ignore: avoid_print
                      print(snapshot.error);
                    }
                    return snapshot.hasData
                        ? Column(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 20),
                                  child: Text(
                                    'Loyalty Reward',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 14),
                                  child: Text(
                                    'Thành viên mới',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 8),
                                  child: Text(
                                    (snapshot.data as MemberShipCurrency)
                                        .totalPointsAccrued
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'T1',
                                            style: TextStyle(
                                                color: checkTextColors(
                                                    (snapshot.data
                                                            as MemberShipCurrency)
                                                        .totalPointsAccrued,
                                                    'Tier 1')),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            'T2',
                                            style: TextStyle(
                                                color: checkTextColors(
                                                    (snapshot.data
                                                            as MemberShipCurrency)
                                                        .totalPointsAccrued,
                                                    'Tier 2')),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'T3',
                                            style: TextStyle(
                                                color: checkTextColors(
                                                    (snapshot.data
                                                            as MemberShipCurrency)
                                                        .totalPointsAccrued,
                                                    'Tier 3')),
                                          ),
                                          const SizedBox(
                                            width: 46,
                                          ),
                                          Text(
                                            'T4',
                                            style: TextStyle(
                                                color: checkTextColors(
                                                    (snapshot.data
                                                            as MemberShipCurrency)
                                                        .totalPointsAccrued,
                                                    'Tier 4')),
                                          ),
                                          const SizedBox(
                                            width: 113,
                                          ),
                                          Text(
                                            'T5',
                                            style: TextStyle(
                                                color: checkTextColors(
                                                    (snapshot.data
                                                            as MemberShipCurrency)
                                                        .totalPointsAccrued,
                                                    'Tier 5')),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GFProgressBar(
                                        animateFromLastPercentage: true,
                                        percentage: checkPoint((snapshot.data
                                                as MemberShipCurrency)
                                            .totalPointsAccrued
                                            .toDouble()),
                                        lineHeight: 16,
                                        alignment:
                                            MainAxisAlignment.spaceBetween,
                                        backgroundColor: Colors.grey.shade200,
                                        progressBarColor: Colors.purple,
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: CustomTierDetailsInfomation(),
                                )
                              ])
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  })),
        ),
      ),
    );
  }
}
