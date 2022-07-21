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
    List<Notification> notifications = [];
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      for (var i = 0; i < jsondata.length; i++) {
        Notification notification = Notification(
          jsondata[i]?['id'],
          'assets/images/IconNotification.png',
          jsondata[i]?['title'],
          jsondata[i]?['body'],
          jsondata[i]?['date'],
          jsondata[i]?['isRead'],
        );
        notifications.add(notification);
      }
      return notifications;
    } else if (response.statusCode == 400) {
      return notifications;
    } else {
      throw Exception("Invalid response");
    }
  }
}
