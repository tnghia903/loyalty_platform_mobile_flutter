import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../object/member_tier.dart';

class MemberTierServices {
  Future<MemberTier> getMemberTier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var memberId = prefs.getString('accountId');
    var response = await http.get(
        Uri.parse(
            'http://13.232.213.53/api/v1/member-tiers/current/$memberId?pageNumber=1&pageSize=13'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});

    var jsondata = json.decode(response.body);

    MemberTier membertier = MemberTier(
        jsondata['name'],
        jsondata['expirationDate'],
        jsondata['effectiveDate'],
        jsondata['updateTierDate']);
    return membertier;
  }
}
