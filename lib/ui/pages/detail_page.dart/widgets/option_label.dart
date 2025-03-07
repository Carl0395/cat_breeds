import 'package:flutter/material.dart';

class OptionLabel extends StatelessWidget {
  const OptionLabel({
    super.key,
    required this.label,
    this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        children: [
          TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
            text: value ?? 'unknown',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
