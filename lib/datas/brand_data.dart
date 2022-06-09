import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/object/brand.dart';

List<Brand> getBrands() {
  List<Brand> items = <Brand>[];

  items.add(Brand(
      'Passio',
      'Passio Coffee là thương hiệu tiên phong trong phong cách “to go” – cafe mang đi tại Việt Nam. Trải qua hơn một thập kỷ hình thành và phát triển, Passio Coffee là lựa chọn lý tưởng của những “tín đồ cafe”. Quyến rũ nhưng cũng rất tao nhã, truyền thống nhưng không kém phần hiện đại, Passio Coffee mong muốn khách hàng sẽ khám phá được sự liên kết đặc biệt trong từng nguyên liệu đã làm nên ly thức uống tuyệt hảo chứ không đơn thuần chỉ là thưởng thức một sản phẩm cafe.',
      'assets/images/brandCoffee.jpg',
      'assets/images/LogoPassio.png',
      Colors.lightGreen.shade600,
      'assets/images/PassioBrandDetail.jpg'));

  return items;
}
