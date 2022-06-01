import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/screens/register_screen.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/buttons/primary_button.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/buttons/secondary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  onPressed: () {},
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
