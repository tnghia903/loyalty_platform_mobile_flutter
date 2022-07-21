import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyalty_platform_mobile_flutter/services/membership_currency_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String? userDisplayName;

  const ProfileScreen({Key? key, this.userDisplayName}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final name = user?.displayName;
final email = user?.email;
final avatarUrl = user?.photoURL;

class _ProfileScreenState extends State<ProfileScreen> {
  String? _accessToken;
  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('access token ne: ${prefs.getString('accessToken')}');
    print('id token ne: ${prefs.getString('accountId')}');
    print('DeviceId token ne: ${prefs.getString('deviceId')}');
  }

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
    getAccessToken();
    getCode();
  }

  String checkAldready(String? email) {
    if (email != null) {
      return email;
    } else {
      return "";
    }
  }

  String? emailreference;
  int? referrerMemberId;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff7f6fb),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(avatarUrl!),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    // 'Registration',
                    name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(email!)
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Email người giới thiệu : ${checkAldready(emailreference)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Mã giới thiệu : $code',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Nhập mã giới thiệu",
                      labelText: "Nhập mã giới thiệu",
                      labelStyle: TextStyle(color: Colors.purple),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.clear();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String token = prefs.getString('accessToken').toString();
                      String memberCode = controller.text.toString();
                      final response = await http.post(
                        Uri.parse(
                            "http://13.232.213.53/api/v1/referrers/send?memberCode=$memberCode"),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'Bearer $token',
                        },
                      );
                      if (response.statusCode == 200) {
                        emailreference = jsonDecode(response.body)['email'];
                        referrerMemberId =
                            jsonDecode(response.body)['referrerMemberId'];
                        Fluttertoast.showToast(
                            msg: "Đã nhập mã thành công!", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.BOTTOM, // location
                            timeInSecForIosWeb: 1 // duration
                            );
                      } else {
                        emailreference = '';
                        referrerMemberId = 0;
                        Fluttertoast.showToast(
                            msg:
                                "Nhập mã thất bại! Vui lòng thử lại sau!", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.BOTTOM, // location
                            timeInSecForIosWeb: 1 // duration
                            );
                      }
                      setState(() {
                        emailreference = emailreference;
                      });
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        // 'Send',
                        'Nhập mã',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await http.post(
                          Uri.parse("http://13.232.213.53/api/v1/auth/logout"),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode(
                            <String, String?>{
                              'idToken': prefs.getString('idTokenGoogle'),
                              'deviceId': prefs.getString('deviceId'),
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          // 'Send',
                          'Sign Out',
                          style: TextStyle(fontSize: 16),
                        ),
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
