import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/buttons/primary_button.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/buttons/secondary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print('idToken Google: ${credential.idToken}');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('idTokenGoogle', credential.idToken!);

    // Once signed in, return UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<void> _signInAnonymously() async {
  //   try {
  //     await FirebaseAuth.instance.signInAnonymously();
  //   } catch (e) {
  //     print(e); // TODO: show dialog with error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 34, bottom: 20),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/illustration-1.png',
                  width: 240,
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Let's get started",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Never a better time than now to start",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 38,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.width * .15,
                  child: SecondaryButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      // Obtain shared preferences.
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) async {
                        if (user == null) {
                          signInWithGoogle();
                          print('User is currently signed out!');
                        } else {
                          print(user.uid);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RootApp(),
                            ),
                          );
                        }
                      });
                      print('goi api ne ${pref.getString('idTokenGoogle')}');
                      final response = await http.post(
                        Uri.parse("http://13.232.213.53/api/v1/auth/login"),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(
                          <String, String?>{
                            'idToken': pref.getString('idTokenGoogle'),
                          },
                        ),
                      );

                      if (response.statusCode == 200) {
                        print(
                            'response login ne: ${jsonDecode(response.body)}');
                        String accessToken = jsonDecode(response.body)['token'];
                        pref.setString('accessToken', accessToken.toString());
                        int accountId = jsonDecode(response.body)['accountId'];
                        pref.setString('accountId', accountId.toString());
                      } else {
                        print('hong co duoc: ${jsonDecode(response.body)}');
                      }
                    },
                    // onPressed: _signInAnonymously,
                    title: 'Login with Google',
                    child: Image.asset(
                      'assets/images/ic-google.webp',
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.width * .15,
                  child: PrimaryButton(
                    onPressed: () async {
                      // Obtain shared preferences.
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) async {
                        if (user == null) {
                          signInWithGoogle();
                          print('User is currently signed out!');
                        } else {
                          print(user);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RootApp(),
                            ),
                          );
                        }
                      });
                    },
                    // onPressed: _signInAnonymously,
                    title: 'Register with Google',
                    // child: Image.asset(
                    //   'assets/images/ic-google.webp',
                    //   width: 40,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
