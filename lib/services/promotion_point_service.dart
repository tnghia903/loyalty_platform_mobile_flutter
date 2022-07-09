import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../object/promotion_point_vourcher.dart';

class PromotionVoucherService {
  getPromotionVoucher() async {
    // var response = await http.get(Uri.parse(
    //     'http://13.232.213.53/api/v1/vouchers'));

    var response = await http.get(Uri.parse(
        'http://13.232.213.53/api/v1/vouchers?pageNumber=1&pageSize=13'));
    var jsondata = json.decode(response.body);

    List<PromotionPointVoucher> vouchers = [];

    for (var i = 0; i < jsondata.length; i++) {
      PromotionPointVoucher voucher = PromotionPointVoucher(
        jsondata[i]['image'],
        jsondata[i]['description'],
        jsondata[i]['effectiveDate'],
        jsondata[i]['expirationDate'],
        jsondata[i]['point'],
        jsondata[i]['name'],
      );
      vouchers.add(voucher);
    }

    return vouchers;
  }
}
