import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
    this.size,
    this.rating = 0,
    this.color,
    this.label,
  });

  final double? size;
  final int rating;
  final Color? color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null)
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? CupertinoIcons.star_fill : CupertinoIcons.star,
              size: size,
              color: color,
            );
          }),
        ),
      ],
    );
  }
}
