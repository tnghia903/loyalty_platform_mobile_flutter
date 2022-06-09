import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  final String? userDisplayName;

  const RegisterScreen({Key? key, this.userDisplayName}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static String _username = "";

  Future<void> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? "my friend";
    });
  }

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
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/illustration-2.png'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  // 'Registration',
                  'Welcome, $_username',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Text(
                //   "Add your phone number. We'll send you a verification code so we know you're real",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black38,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(
                //   height: 28,
                // ),
                Container(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   decoration: InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //         borderSide:
                      //             const BorderSide(color: Colors.black45),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             const BorderSide(color: Colors.purple),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     prefix: const Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 8),
                      //       child: Text(
                      //         "(+84)",
                      //         style: TextStyle(
                      //             fontSize: 18, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     suffixIcon: const Icon(
                      //       Icons.check_circle_rounded,
                      //       color: Colors.green,
                      //       size: 32,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 22,
                      // ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // onPressed: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const OtpScreen()));
                          // },
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
