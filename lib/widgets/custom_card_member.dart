import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import 'package:loyalty_platform_mobile_flutter/screens/member_detail_screen.dart';

import '../services/membership_currency_services.dart';

class CustomCardMembers extends StatefulWidget {
  const CustomCardMembers({super.key});

  @override
  State<CustomCardMembers> createState() => _CustomCardMembersState();
}

class _CustomCardMembersState extends State<CustomCardMembers> {
  String? code;

  getCode() async {
    var membershipcurrency =
        await MemberShipCurrencyService().getMemberShipCurrency();

    setState(() {
      code = membershipcurrency.membershipCode;
    });
  }

  @override
  void initState() {
    super.initState();
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => (const MemberDetailScreen())),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(16),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage("assets/images/LoyaltyCard.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.width * .3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: BarcodeWidget(
                    textPadding: 16,
                    data: code.toString(),
                    barcode: Barcode.code128(),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
