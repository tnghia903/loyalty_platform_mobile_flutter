import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  @override
  void initState() {
    super.initState();
    getAccessToken();
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
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const OtpScreen()));
                    // },
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
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
                        'Sign Out',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
