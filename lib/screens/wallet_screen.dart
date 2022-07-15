import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_platform_mobile_flutter/object/card.dart';
import 'package:loyalty_platform_mobile_flutter/services/card_service.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * .7,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple,
                        Color.fromARGB(255, 222, 159, 233),
                      ]),
                    ),
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
                              image: AssetImage("assets/images/CashCard.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: FutureBuilder(
                              future: CardService().getCard(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  // ignore: avoid_print
                                  print(snapshot.error);
                                }
                                return snapshot.hasData
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, top: 60),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                (snapshot.data as CardMoney)
                                                    .cardholderName,
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Color.fromARGB(
                                                      255, 132, 14, 153),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Số dư : ${NumberFormat.currency(locale: 'vi_VN').format((snapshot.data as CardMoney).amount)}',
                                              // 'Số dư : ${(snapshot.data as CardMoney).amount}',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.purple,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            Text(
                                              (snapshot.data as CardMoney)
                                                  .createdAt,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 212, 115, 230),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                        )),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width * .2,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          border: Border(
                        left: BorderSide(width: 0.5),
                        right: BorderSide(width: 0.5),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: const [
                            Icon(Icons.input_rounded),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Nạp tiền',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.width * .2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 0.5),
                      left: BorderSide(width: 0.5),
                      right: BorderSide(width: 0.5),
                      bottom: BorderSide(width: 0.5),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: const [
                          Icon(Icons.shopping_cart_checkout_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Thanh toán',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * .2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(width: 0.5),
                      right: BorderSide(width: 0.5),
                      bottom: BorderSide(width: 0.5),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: const [
                          Icon(Icons.history_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Lịch sử thanh toán',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
