import 'package:flutter/material.dart';
import 'package:loyalty_platform_mobile_flutter/object/promotion.dart';

class PromotionNewsDetailScreen extends StatelessWidget {
  const PromotionNewsDetailScreen({Key? key, required this.items})
      : super(key: key);
  final Promotion items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              automaticallyImplyLeading: false,
              leading: RawMaterialButton(
                shape: const CircleBorder(),
                fillColor: Colors.black.withOpacity(0.2),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              pinned: true,
              elevation: 0.0,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                items.imgUrl,
                fit: BoxFit.fill,
              )),
            ),
            SliverToBoxAdapter(
                child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      children: const [
                        Text('Nội Dung',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(items.description,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.clip,
                        textDirection: TextDirection.ltr,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
