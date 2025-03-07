import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/material.dart';

class TagTemperament extends StatelessWidget {
  const TagTemperament({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.secondaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
