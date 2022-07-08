import 'package:flutter/material.dart';

class CustomPromotionNew extends StatefulWidget {
  const CustomPromotionNew(
      {Key? key, required this.thumbNail, required this.title})
      : super(key: key);

  final String thumbNail;
  final String title;

  @override
  State<CustomPromotionNew> createState() => _CustomPromotionNewState();
}

class _CustomPromotionNewState extends State<CustomPromotionNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * .6,
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(17), topRight: Radius.circular(17)),
              child: Image.asset(
                widget.thumbNail,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
