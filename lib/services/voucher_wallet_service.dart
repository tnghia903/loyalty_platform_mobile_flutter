import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VoucherWalletService {
  Future<List> getVoucherWallets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? membershipId = prefs.getString('accountId');
    String token = prefs.getString('accessToken').toString();
    var url = Uri.parse(
        'http://13.232.213.53/api/v1/voucher-wallets/$membershipId?pageNumber=1&pageSize=10');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
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

  Future<void> addVoucherInWallet(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? membershipId = prefs.getString('accountId');
    String token = prefs.getString('accessToken').toString();
    String url = 'http://13.232.213.53/api/v1/voucher-wallets';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "membershipId": membershipId,
          "voucherDefinitionId": id,
          "status": null,
          "useDate": null,
          "isPartialRedeemable": null,
          "redeemedValue": null,
          "remainingValue": null,
          "description": null
        },
      ),
    );
    if (response.statusCode == 200) {
      print('add thanh cong roi nef ');
    } else {
      print(response.statusCode.toString());
      print(response.toString());
    }
  }
}
