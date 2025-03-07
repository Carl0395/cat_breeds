import 'package:cat_breeds/ui/widgets/custom_line_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final heightCard = 450.0;
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          _label(15),
          SizedBox(height: 16),
          CustomLineShimmer(
            height: heightCard * 0.7,
            width: MediaQuery.of(context).size.width - 64,
          ),
          SizedBox(height: 16),
          _label(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _label([double? height]) {
    return Row(
      children: [
        CustomLineShimmer(
          height: height ?? 10,
          width: 200,
        ),
        Spacer(),
        CustomLineShimmer(
          height: height ?? 10,
          width: 60,
        ),
      ],
    );
  }
}
