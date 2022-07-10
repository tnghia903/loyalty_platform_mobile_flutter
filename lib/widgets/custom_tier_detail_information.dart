import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/services/tier_services.dart';

class CustomTierDetailsInfomation extends StatefulWidget {
  const CustomTierDetailsInfomation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTierDetailsInfomationState createState() =>
      _CustomTierDetailsInfomationState();
}

class _CustomTierDetailsInfomationState
    extends State<CustomTierDetailsInfomation> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getBar(),
        const SizedBox(
          height: 16,
        ),
        getBody()
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [tier1(), tier2(), tier3(), tier4(), tier5()];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getBar() {
    var size = MediaQuery.of(context).size;
    List bottomItems = [
      'Tier 1',
      'Tier 2',
      'Tier 3',
      'Tier 4',
      'Tier 5',
    ];
    return Container(
      width: size.width,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.12),
            blurRadius: 30.0,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, bottom: 10, top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomItems.length, (index) {
              return InkWell(
                  onTap: () {
                    selectedTab(index);
                  },
                  child: Column(
                    children: [
                      Text(
                        bottomItems[index],
                        style: TextStyle(
                          color: pageIndex == index
                              ? Colors.purple
                              : const Color.fromARGB(255, 62, 31, 68),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      (pageIndex == index)
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              child: Container(
                                height: 5.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )
                          : const SizedBox(
                              height: 5.0,
                              width: 20.0,
                            ),
                    ],
                  ));
            }),
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget tier1() {
    return FutureBuilder(
        future: TierService().getTier(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (snapshot.data as List).length;
                          i++) ...[
                        if ((snapshot.data as List)[i].sequenceNumber == 1) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Đạt ${(snapshot.data as List)[i].minPoints} điểm để đạt được Tier 1',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, right: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .71,
                                child: Text(
                                  '⬤  Tier 1 - Tăng hệ số tích điểm lên ${(snapshot.data as List)[i].ratioPoints}',
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ]
                      ],
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget tier2() {
    return FutureBuilder(
        future: TierService().getTier(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (snapshot.data as List).length;
                          i++) ...[
                        if ((snapshot.data as List)[i].sequenceNumber == 2) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Đạt ${(snapshot.data as List)[i].minPoints} điểm để đạt được Tier 2',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, right: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .71,
                                child: Text(
                                  '⬤  Tier 2 - Tăng hệ số tích điểm lên ${(snapshot.data as List)[i].ratioPoints}',
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ]
                      ],
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget tier3() {
    return FutureBuilder(
        future: TierService().getTier(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (snapshot.data as List).length;
                          i++) ...[
                        if ((snapshot.data as List)[i].sequenceNumber == 3) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Đạt ${(snapshot.data as List)[i].minPoints} điểm để đạt được Tier 3',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, right: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .71,
                                child: Text(
                                  '⬤  Tier 3 - Tăng hệ số tích điểm lên ${(snapshot.data as List)[i].ratioPoints}',
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ]
                      ],
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget tier4() {
    return FutureBuilder(
        future: TierService().getTier(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (snapshot.data as List).length;
                          i++) ...[
                        if ((snapshot.data as List)[i].sequenceNumber == 4) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Đạt ${(snapshot.data as List)[i].minPoints} điểm để đạt được Tier 4',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, right: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .71,
                                child: Text(
                                  '⬤  Tier 4 - Tăng hệ số tích điểm lên ${(snapshot.data as List)[i].ratioPoints}',
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ]
                      ],
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget tier5() {
    return FutureBuilder(
        future: TierService().getTier(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (snapshot.data as List).length;
                          i++) ...[
                        if ((snapshot.data as List)[i].sequenceNumber == 5) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 14),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Đạt ${(snapshot.data as List)[i].minPoints} điểm để đạt được Tier 5',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, right: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .71,
                                child: Text(
                                  '⬤  Tier 5 - Tăng hệ số tích điểm lên ${(snapshot.data as List)[i].ratioPoints}',
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ]
                      ],
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
