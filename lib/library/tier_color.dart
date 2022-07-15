import 'dart:ui';

import 'package:flutter/material.dart';

Color? getTierColor(String tier) {
  if (tier == 'Tier 1') return Colors.purple;
  if (tier == 'Tier 2') return Colors.grey[400];
  if (tier == 'Tier 3') return Colors.yellow[600];
  if (tier == 'Tier 4') return Colors.blue[300];
  if (tier == 'Tier 5') return Colors.red[400];
  return null;
}

// class AppColor {
//   static const Color primaryColor = Color(0xFFFAF4EB);
//   static const Color activeNavigation = Color.fromARGB(255, 253, 141, 156);
//   static const Color secondColor = Color(0xFFFADDE1);
//   // static const Color textColor = Color(0xff000000);
//   // static const Color lighBlue = Color(0xffD7E3FC);
//   static const Color greyOulineTextFildColor = Color(0xFF898788);
//   static const Color textHint = Color(0xFF8B8B8B);
//   static const Color buttonColor = Color(0xFFFADDE1);
//   static const Color textButtonColor = Color(0xFF000000);
//   static const Color textBlueBack = Color(0xFF0A0047);
//   // static const Color lightGrey = Color(0xffB2B6BD);
// }
