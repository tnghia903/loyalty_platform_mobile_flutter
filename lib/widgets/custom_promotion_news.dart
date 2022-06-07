import 'package:flutter/material.dart';

class CustomPromotionNew extends StatefulWidget {
  const CustomPromotionNew(
      {Key? key, required this.thumbNail, required this.title})
      : super(key: key);

  final String thumbNail;
  final String title;

  @override
  _CustomPromotionNewState createState() => _CustomPromotionNewState();
}

class _CustomPromotionNewState extends State<CustomPromotionNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * .6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Colors.black26.withOpacity(0.3))
        ],
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .45,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.thumbNail,
                  fit: BoxFit.fill,
                )),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
