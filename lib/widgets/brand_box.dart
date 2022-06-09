import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../object/brand.dart';

class BrandBox extends StatelessWidget {
  const BrandBox({Key? key, required this.item}) : super(key: key);
  final Brand item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 20,
                color: Colors.black26.withOpacity(0.3))
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * .3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  child: Container(
                      width: 90.0,
                      height: MediaQuery.of(context).size.width * .3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: item.primaryColor.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Image.asset(
                        item.logo,
                        color: Colors.white,
                        scale: 20,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
