import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loyalty_platform_mobile_flutter/object/membershipcurrency.dart';
import 'package:loyalty_platform_mobile_flutter/services/membership_currency_services.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/custom_tier_detail_information.dart';

class MemberDetailScreen extends StatefulWidget {
  const MemberDetailScreen({super.key});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
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
                                      left: 20, right: 20, top: 16),
                                  child: GFProgressBar(
                                    percentage:
                                        (((snapshot.data as MemberShipCurrency)
                                                        .totalPointsAccrued
                                                        .toDouble() *
                                                    100) /
                                                160) /
                                            100,
                                    lineHeight: 16,
                                    alignment: MainAxisAlignment.spaceBetween,
                                    backgroundColor: Colors.grey.shade200,
                                    progressBarColor: Colors.purple,
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
