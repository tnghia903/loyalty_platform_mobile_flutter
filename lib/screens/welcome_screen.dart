import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loyalty_platform_mobile_flutter/root_app.dart';
import 'package:loyalty_platform_mobile_flutter/screens/register_screen.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/buttons/secondary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
                width: double.infinity,
                child: SecondaryButton(
                  onPressed: () async {
                    // Obtain shared preferences.
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) async {
                      if (user == null) {
                        signInWithGoogle();
                        print('User is currently signed out!');
                      } else {
                        print(user.displayName);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('username', user.displayName.toString());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RootApp(),
                          ),
                        );
                      }
                    });
                  },
                  // onPressed: _signInAnonymously,
                  title: 'Login with Google',
                  child: Image.asset(
                    'assets/images/ic-google.webp',
                    width: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
