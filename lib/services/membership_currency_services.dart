import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../object/membershipcurrency.dart';

class MemberShipCurrencyService {
  Future<MemberShipCurrency> getMemberShipCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var memberId = prefs.getString('accountId');

    var response = await http.get(
        Uri.parse('http://13.232.213.53/api/v1/member-currencies/$memberId/2'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
    var jsondata = json.decode(response.body);
    MemberShipCurrency memberShipCurrency = MemberShipCurrency(
      jsondata['totalPointsRedeemed'],
      jsondata['totalPointsExpired'],
      jsondata['totalPointsAccrued'],
      jsondata['balanceBeforeReset'],
      jsondata['expirationPoints'],
    );

    return memberShipCurrency;
  }
}
