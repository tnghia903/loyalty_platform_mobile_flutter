import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loyalty_platform_mobile_flutter/datas/brand_data.dart';
import 'package:loyalty_platform_mobile_flutter/object/brand.dart';
import 'package:loyalty_platform_mobile_flutter/screens/brands_detail.dart';
import 'package:loyalty_platform_mobile_flutter/widgets/brand_box.dart';

class BrandsListScreen extends StatelessWidget {
  BrandsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = getBrands();
    return Scaffold(
        appBar: AppBar(
          title: Text('Thương hiệu'),
          elevation: 0,
          backgroundColor: Colors.purple[400],
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: BrandBox(item: items[index]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              BrandDetailScreen(items: items[index]))));
                },
              );
            }));
  }
}
