import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/library/tier_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBarHomeScreen extends StatefulWidget {
  const CustomAppBarHomeScreen({super.key});

  @override
  State<CustomAppBarHomeScreen> createState() => _CustomAppBarHomeScreenState();
}

class _CustomAppBarHomeScreenState extends State<CustomAppBarHomeScreen> {
  String? point;
  String? tier;

  Future<void> getInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    point = prefs.getString('point');
    tier = prefs.getString('tier').toString();
  }

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final name = user?.displayName;
    final avatarUrl = user?.photoURL;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(avatarUrl!),
              )),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Text(
                    name!,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: getTierColor(tier.toString()),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, bottom: 2, top: 2, right: 4),
                    child: Text(
                      tier.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Color.fromARGB(255, 222, 159, 233),
                ]),
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      point.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8, top: 4, bottom: 2),
                        child: Text(
                          'P',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
