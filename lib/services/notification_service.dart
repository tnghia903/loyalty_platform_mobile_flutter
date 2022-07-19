import 'package:loyalty_platform_mobile_flutter/object/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NotificationService {
  Future<List> getNoti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var memberId = prefs.getString('accountId');

    var response = await http.get(
        Uri.parse(
            'http://13.232.213.53/api/v1/notification?accountId=$memberId'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});
    var jsondata = json.decode(response.body);
    List<Notification> notifications = [];
    for (var i = 0; i < jsondata.length; i++) {
      Notification notification = Notification(
        'assets/images/IconNotification.png',
        jsondata[i]['title'],
        jsondata[i]['body'],
        jsondata[i]['date'],
        jsondata[i]['isRead'],
      );
      notifications.add(notification);
    }

    return notifications;
  }
}
