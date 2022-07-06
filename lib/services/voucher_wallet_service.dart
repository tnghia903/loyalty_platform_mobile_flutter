import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VoucherWalletService {
  Future<List> getVoucherWallets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? membershipId = prefs.getString('accountId');
    var url =
        Uri.parse('http://13.232.213.53/api/v1/voucher-wallets/$membershipId');
    final response = await http.get(url);
    List listVoucherDefinition = [];
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      for (var i = 0; i < list.length; i++) {
        listVoucherDefinition.add(list[i]['voucherDefinition']);
      }
      // list = List<VoucherDefinitionObject>.from
      return listVoucherDefinition;
    } else
      (throw Exception('Failed to load voucher definition'));
  }
}
