import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/object/promotion_point_vourcher.dart';

class PromotionPointVoucherDetailScreen extends StatelessWidget {
  const PromotionPointVoucherDetailScreen({Key? key, required this.items})
      : super(key: key);
  final PromotionPointVoucher items;
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
            floating: true,
            pinned: true,
            elevation: 0.0,
            snap: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Image.asset(
                      items.thumbNail,
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
                      Text(items.title,
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
                  child: Text(items.description,
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
                      onPressed: () {},
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
