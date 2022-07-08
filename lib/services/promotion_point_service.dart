import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../object/promotion_point_vourcher.dart';

class PromotionVoucherService {
  getPromotionVoucher() async {
    // var response = await http.get(Uri.parse(
    //     'http://13.232.213.53/api/v1/vouchers'));
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJlbWFpbCI6InRydW5ncGhhbXB0dHRAZ21haWwuY29tIiwianRpIjoiMGRhZmNkZjAtZmFhYy00YzFjLTg2ZWUtM2IxMGM2NTE3OGYzIiwicm9sZSI6InVzZXIiLCJleHAiOjE2NTcyOTA2OTksImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9sb3lhbHR5LXBsYXRmb3JtLWRiYjA1IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0OTYyMi9pbmRleC5odG1sIn0.qVIJA5Z0xkzR5mOnXMjbez4CyBEStXDLe2mczKfnsJk';
    var response = await http.get(
        Uri.parse('http://13.232.213.53/api/v1/vouchers'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
    var jsondata = json.decode(response.body);

    List<PromotionPointVoucher> vouchers = [];

    for (var i = 0; i < jsondata.length; i++) {
      PromotionPointVoucher voucher = PromotionPointVoucher(
        jsondata[i]['image'],
        jsondata[i]['description'],
        jsondata[i]['effectiveDate'],
        jsondata[i]['expirationDate'],
        '0',
        jsondata[i]['name'],
      );
      vouchers.add(voucher);
    }

    return vouchers;
  }
}
