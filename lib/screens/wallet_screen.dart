import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Column(children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: const Border(
                              top: BorderSide(width: 2, color: Colors.white),
                              left: BorderSide(width: 2, color: Colors.white),
                              right: BorderSide(width: 2, color: Colors.white),
                              bottom: BorderSide(width: 2, color: Colors.white),
                            )),
                        child: const Center(
                          child: Text(
                            "Số dư",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      const Text(
                        '200.000 VNĐ',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ]),
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
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: const [
                        Icon(Icons.input_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Nạp tiền'),
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
                      Text('Thanh toán'),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
