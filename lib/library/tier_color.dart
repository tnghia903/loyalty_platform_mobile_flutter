import 'package:flutter/material.dart';

Color? getTierColor(String tier) {
  if (tier == 'Tier 1') return Colors.purple;
  if (tier == 'Tier 2') return Colors.grey[400];
  if (tier == 'Tier 3') return Colors.yellow[600];
  if (tier == 'Tier 4') return Colors.blue[300];
  if (tier == 'Tier 5') return Colors.red[400];
  return null;
}
