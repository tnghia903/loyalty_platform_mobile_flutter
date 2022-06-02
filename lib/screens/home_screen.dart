import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:
                              Image.asset('assets/images/profilepicture.png'),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Row(children: [
                          Text(
                            "Hello ABC",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.purple[900],
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "Silver Member ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.purple[900],
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Color.fromARGB(255, 222, 159, 233),
                            ]),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(10, 10),
                                blurRadius: 20,
                                color: Color.fromARGB(255, 222, 159, 233)
                                    .withOpacity(0.3),
                              )
                            ]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "2000 P",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple,
                        Color.fromARGB(255, 222, 159, 233),
                      ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(10, 10),
                          blurRadius: 20,
                          color: Color.fromARGB(255, 222, 159, 233)
                              .withOpacity(0.3),
                        )
                      ]),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 18),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 20,
                                            color:
                                                Colors.black26.withOpacity(0.3))
                                      ]),
                                  child: Icon(
                                    Icons.near_me_sharp,
                                    size: 35,
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 70, top: 18),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 20,
                                            color:
                                                Colors.black26.withOpacity(0.3))
                                      ]),
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 35,
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 70, top: 18),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 20,
                                            color:
                                                Colors.black26.withOpacity(0.3))
                                      ]),
                                  child: Icon(
                                    Icons.card_giftcard,
                                    size: 35,
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Tìm Nhà Hàng",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 42,
                              ),
                              Text(
                                "Thương Hiệu",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Ví Voucher",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  children: [
                    Text(
                      "Ưu đãi cho bạn",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple[900],
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: Colors.black26.withOpacity(0.3))
                      ],
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Promotion3.png'),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: Colors.black26.withOpacity(0.3))
                      ],
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Promotion2.png'),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: Colors.black26.withOpacity(0.3))
                      ],
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Promotion1.png'),
                      )),
                )
              ],
            ),
          )),
    ));
  }
}
