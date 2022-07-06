import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loyalty_platform_mobile_flutter/object/promotion.dart';

class PromotionService {
  getPromotion() async {
    var response = await http.get(Uri.parse(
        'https://api-promotion-engine.reso.vn/api/promotions?PageSize=10&PageIndex=1&BrandId=dbe5e8e0-363b-4119-a145-6c7775abf4d3&status=0'));
    var jsonData = jsonDecode(response.body);
    List<Promotion> promotions = [];

    // for (var u in jsonData) {
    //   Promotion promotion = Promotion(u["image"], u["description"], u["name"]);
    //   promotions.add(promotion);
    // }
    for (var i = 0; i < jsonData.length; i++) {
      Promotion promotion = Promotion(jsonData['data'][i]['imgUrl'],
          jsonData['data'][i]['description'], jsonData['data'][i]['promotionName']);
      promotions.add(promotion);
    }

    print(promotions.length);
    return promotions;
  }
}
