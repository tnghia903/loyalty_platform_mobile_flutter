import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyalty_platform_mobile_flutter/object/promotion_point_vourcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/membership_currency_services.dart';
import '../services/voucher_wallet_service.dart';

class PromotionPointVoucherDetailScreen extends StatefulWidget {
  const PromotionPointVoucherDetailScreen(
      {Key? key, required this.items, required this.update})
      : super(key: key);
  final Function update;
  final PromotionPointVoucher items;

  @override
  State<PromotionPointVoucherDetailScreen> createState() =>
      _PromotionPointVoucherDetailScreenState();
}

class _PromotionPointVoucherDetailScreenState
    extends State<PromotionPointVoucherDetailScreen> {
  Future<bool> checkPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? point = prefs.getString('point');
    return int.parse(point!) >= int.parse(widget.items.point.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
            automaticallyImplyLeading: false,
            actions: [
              SizedBox(
                width: 35,
                height: 35,
                child: RawMaterialButton(
                    shape: const CircleBorder(),
                    fillColor: Colors.black.withOpacity(0.2),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    )),
              ),
            ],
            pinned: true,
            elevation: 0.0,
            snap: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Image.network(
                      widget.items.thumbNail,
                      fit: BoxFit.fill,
                    ))),
          ),
          SliverToBoxAdapter(
              child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      Text(widget.items.title,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.clip,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Text(widget.items.description,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.clip,
                      textDirection: TextDirection.ltr,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: const Text('Đổi ngay'),
                      onPressed: () async {
                        bool check = await checkPoint();
                        if (check) {
                          VoucherWalletService()
                              .addVoucherInWallet(widget.items.id);
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          List response = await Future.wait([
                            MemberShipCurrencyService().getMemberShipCurrency()
                          ]);
                          pref.setString(
                              'point', response[0].pointsBalance.toString());
                          widget.update();
                          Fluttertoast.showToast(
                              msg: "Đổi thành công", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.BOTTOM, // location
                              timeInSecForIosWeb: 1 // duration
                              );
                          print(pref.getString('point'));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Bạn không đủ điểm", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.BOTTOM, // location
                              timeInSecForIosWeb: 1 // duration
                              );
                        }
                        setState(() {});
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
