import 'package:cat_breeds/ui/pages/home_page/widgets/loading_card.dart';
import 'package:flutter/material.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        LoadingCard(),
        SizedBox(height: 20),
        LoadingCard(),
        SizedBox(height: 20),
        LoadingCard(),
      ],
    );
  }
}
