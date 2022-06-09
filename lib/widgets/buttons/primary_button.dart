import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;

  const PrimaryButton({Key? key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          title ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
