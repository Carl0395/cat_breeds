import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/material.dart';

class AttributeBox extends StatelessWidget {
  const AttributeBox({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: scheme.secondaryColor.withValues(alpha: 0.1),
        border: Border.all(
            width: 0.5, color: scheme.secondaryColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
