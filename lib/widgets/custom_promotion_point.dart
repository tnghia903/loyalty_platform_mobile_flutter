import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomPromotionPoint extends StatefulWidget {
  const CustomPromotionPoint(
      {Key? key,
      required this.thumbNail,
      required this.title,
      required this.duration,
      required this.point})
      : super(key: key);

  final String thumbNail;
  final String title;
  final String duration;
  final String point;

  @override
  State<CustomPromotionPoint> createState() => _CustomPromotionPointState();
}

class _CustomPromotionPointState extends State<CustomPromotionPoint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: Colors.black26.withOpacity(0.3))
        ],
      ),
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.width * .45,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.thumbNail,
                fit: BoxFit.fill,
              )),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                Text(
                  widget.duration,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      widget.point,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.purple[800],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6, top: 1),
                        child: Text(
                          'P',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 110,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Đổi ngay',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            )
          ],
        )
      ]),
    );
  }
}
