import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loyalty_platform_mobile_flutter/object/brand.dart';

class BrandDetailScreen extends StatelessWidget {
  const BrandDetailScreen({Key? key, required this.items}) : super(key: key);
  final Brand items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items.name),
        elevation: 0,
        backgroundColor: items.primaryColor,
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
                    items.logo,
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
                        items.imageintroduction,
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
                  items.description,
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
