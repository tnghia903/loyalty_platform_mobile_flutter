import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../object/card.dart';

class CardService {
  Future<CardMoney> getCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var memberId = prefs.getString('accountId');

    var response = await http.get(
        Uri.parse('http://13.232.213.53/api/v1/cards/$memberId'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
    var jsondata = json.decode(response.body);
    CardMoney card = CardMoney(
      jsondata['cardholderName'],
      jsondata['amount'].toDouble(),
      jsondata['createdAt'],
    );

    return card;
  }
}
