import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: breed.name ?? '',
      ),
    );
  }
}
