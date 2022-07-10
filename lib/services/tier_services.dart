import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:loyalty_platform_mobile_flutter/object/promotion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../object/Tier.dart';

class TierService {
  getTier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var response = await http.get(
        Uri.parse('http://13.232.213.53/api/v1/tiers?pageNumber=1&pageSize=13'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});

    var jsondata = json.decode(response.body);
    List<Tier> tiers = [];
    for (var i = 0; i < jsondata.length; i++) {
      if (jsondata[i]['loyaltyProgramId'] == 1) {
        Tier tier = Tier(
            jsondata[i]['id'],
            jsondata[i]['loyaltyProgramId'],
            jsondata[i]['minPoints'].toDouble(),
            jsondata[i]['ratioPoints'].toDouble(),
            jsondata[i]['sequenceNumber']);
        tiers.add(tier);
      }
    }

    return tiers;
  }
}
