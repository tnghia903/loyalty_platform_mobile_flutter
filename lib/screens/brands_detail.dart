import 'package:flutter/material.dart';

class BrandDetailScreen extends StatelessWidget {
  const BrandDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Loyalty Program Coffee'),
        elevation: 0,
        backgroundColor: Colors.purple.shade600,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/LoyaltyProgram_logo(2).png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.asset(
                        'assets/images/BrandDetail.jpg',
                        fit: BoxFit.fill,
                      ))),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Sài Gòn tấp nập, xô bồ, đôi khi cần lắm một phút giây yên bình. Tìm đến một quán nước nhỏ nhắn, âm nhạc nhẹ nhàng, say sưa cùng với vài trang sách. Vậy là đủ cho một ngày cuối tuần. Nếu đó là những điều bạn tìm kiếm thì Loyalty Program Coffee là không gian lý tưởng cho bạn đấy.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
