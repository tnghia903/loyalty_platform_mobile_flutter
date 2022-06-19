import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loyalty_platform_mobile_flutter/object/brand.dart';

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
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text('Passio'),
        elevation: 0,
        backgroundColor: Colors.lightGreen.shade600,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black26.withOpacity(0.3))
                      ],
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white),
                  child: Image.asset(
                    'assets/images/LogoPassio.png',
                    scale: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.asset(
                        'assets/images/PassioBrandDetail.jpg',
                        fit: BoxFit.fill,
                      ))),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Passio Coffee là thương hiệu tiên phong trong phong cách “to go” – cafe mang đi tại Việt Nam. Trải qua hơn một thập kỷ hình thành và phát triển, Passio Coffee là lựa chọn lý tưởng của những “tín đồ cafe”. Quyến rũ nhưng cũng rất tao nhã, truyền thống nhưng không kém phần hiện đại, Passio Coffee mong muốn khách hàng sẽ khám phá được sự liên kết đặc biệt trong từng nguyên liệu đã làm nên ly thức uống tuyệt hảo chứ không đơn thuần chỉ là thưởng thức một sản phẩm cafe.',
                  style: const TextStyle(
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
