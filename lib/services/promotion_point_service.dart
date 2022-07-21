import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../object/promotion_point_vourcher.dart';

class PromotionVoucherService {
  Future<List> getPromotionVoucher() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var response = await http.get(
        Uri.parse('http://13.232.213.53/api/v1/vouchers/user'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
    var jsondata = json.decode(response.body);

    List<PromotionPointVoucher> vouchers = [];

    for (var i = 0; i < jsondata.length; i++) {
      if (jsondata[i]['point'] != 0) {
        PromotionPointVoucher voucher = PromotionPointVoucher(
          jsondata[i]['id'],
          jsondata[i]['image'],
          jsondata[i]['description'],
          jsondata[i]['effectiveDate'],
          jsondata[i]['expirationDate'],
          jsondata[i]['point'],
          jsondata[i]['name'],
        );
        vouchers.add(voucher);
      }
    }

    return vouchers;
  }
}
