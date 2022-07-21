import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/screens/brands_detail.dart';
import 'package:loyalty_platform_mobile_flutter/screens/map_screen.dart';
import 'package:loyalty_platform_mobile_flutter/screens/voucher_wallet.dart';

class CustomFunctionBar extends StatelessWidget {
  const CustomFunctionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tilte = [
      "Tìm Cửa Hàng",
      "Thương Hiệu",
      "Ví Voucher",
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.purple,
            Color.fromARGB(255, 222, 159, 233),
          ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 30,
              color: const Color.fromARGB(255, 222, 159, 233).withOpacity(0.7),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 20,
                                    color: Colors.black26.withOpacity(0.3))
                              ]),
                          child: IconButton(
                            icon: const Icon(Icons.near_me_sharp),
                            iconSize: 35,
                            color: Colors.purple[900],
                            onPressed: () async {
                              await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomMarkerWithNetworkImage()));
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 20,
                                    color: Colors.black26.withOpacity(0.3))
                              ]),
                          child: IconButton(
                            icon: const Icon(
                              Icons.restaurant,
                            ),
                            iconSize: 35,
                            color: Colors.purple[900],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (const BrandDetailScreen())),
                              );
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 20,
                                    color: Colors.black26.withOpacity(0.3))
                              ]),
                          child: IconButton(
                            icon: const Icon(
                              Icons.card_giftcard,
                            ),
                            iconSize: 35,
                            color: Colors.purple[900],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (const VoucherWallet())),
                              );
                            },
                          )),
                    )
                  ]),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    tilte.length,
                    (index) => Text(
                      tilte[index],
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
