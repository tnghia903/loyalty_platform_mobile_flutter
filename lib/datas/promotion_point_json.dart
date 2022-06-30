import 'package:loyalty_platform_mobile_flutter/object/promotion_point_vourcher.dart';

List<PromotionPointVoucher> getPromotionPointVoucher() {
  List<PromotionPointVoucher> items = <PromotionPointVoucher>[];
  items.add(PromotionPointVoucher(
      'assets/images/Promotion3.png',
      'Cafe uống nóng hoặc lạnh chứ không uống nguội bao giờ. Cũng như đời sống luôn có khao khát và thất bại chứ không thể lặng lẽ bỏ qua quá nhiều những cơ hội.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      '12/06/2022 - 15/06/2022',
      '0',
      'Coupon giảm 35k 1 ly nước bất kỳ'));
  items.add(PromotionPointVoucher(
      'assets/images/Promotion2.png',
      'Cafe uống nóng hoặc lạnh chứ không uống nguội bao giờ. Cũng như đời sống luôn có khao khát và thất bại chứ không thể lặng lẽ bỏ qua quá nhiều những cơ hội.',
      '17/06/2022 - 19/06/2022',
      '1000',
      'Coupon giảm 40% cho 1 ly cà phê'));
  items.add(PromotionPointVoucher(
      'assets/images/Promotion1.png',
      'Cafe uống nóng hoặc lạnh chứ không uống nguội bao giờ. Cũng như đời sống luôn có khao khát và thất bại chứ không thể lặng lẽ bỏ qua quá nhiều những cơ hội.',
      '20/06/2022 - 25/06/2022',
      '2000',
      'Coupon giảm 58% cho 1 ly cà phê'));
  return items;
}
