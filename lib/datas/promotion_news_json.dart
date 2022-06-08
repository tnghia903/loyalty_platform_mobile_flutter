import 'package:loyalty_platform_mobile_flutter/object/promotion.dart';

List<Promotion> getPromotion() {
  List<Promotion> items = <Promotion>[];

  items.add(Promotion(
      'assets/images/Promotion3.png',
      'Cafe uống nóng hoặc lạnh chứ không uống nguội bao giờ. Cũng như đời sống luôn có khao khát và thất bại chứ không thể lặng lẽ bỏ qua quá nhiều những cơ hội.',
      'Ưu đãi mùa hè chỉ từ 35k 1 ly nước bất kì'));
  items.add(Promotion(
      'assets/images/Promotion2.png',
      'Phút tĩnh lặng bên ly cafe, không gian dường như được tách biệt với thế giới bên ngoài, xô bồ va hối hả. Gợi nhớ những kỉ niệm, ký ức của chính mình và cá nhân, về đời.',
      'Ưu đãi đặc biệt giảm giá 45% cho 1 ly cà phê'));
  items.add(Promotion(
      'assets/images/Promotion1.png',
      'Cuộc đời của chúng ta tương tự tách cafe. tuy nhiên Thông thường chỉ vì chạy theo những cái tách mà chúng ta đã vô tình bỏ lỡ cơ hội thưởng thức cafe.',
      'Đến ngay Fresh Coffee để nhận được ưu đãi 25% cho 1 ly cà phê chào buổi sáng'));

  return items;
}
