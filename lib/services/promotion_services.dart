import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loyalty_platform_mobile_flutter/object/promotion.dart';

class PromotionService {
  getPromotion() async {
    var response = await http.get(Uri.parse(
        'https://api-promotion-engine.reso.vn/api/promotions?PageSize=10&PageIndex=1&BrandId=dbe5e8e0-363b-4119-a145-6c7775abf4d3&status=0'));

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    List<Promotion> promotions = [];

    for (var i = 0; i < data.length; i++) {
      Promotion promotion = Promotion(
          data[i]['imgUrl'],
          (data[i]['description'] != null) ? data[i]['description'] : '',
          data[i]['promotionName']);
      promotions.add(promotion);
    }

    return promotions;
  }
}