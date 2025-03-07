import 'dart:io';

import 'package:cat_breeds/controllers/breeds_controller.dart';
import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/ui/pages/detail_page.dart/detail_page.dart';
import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:cat_breeds/ui/widgets/custom_network_image.dart';
import 'package:cat_breeds/ui/widgets/tag_temperament.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreedCard extends StatelessWidget {
  const BreedCard({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    final heightCard = 450.0;
    final images = Get.find<BreedsController>().photosByBreed[breed.id];
    return GestureDetector(
      onTap: () => showDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(width: 0.5, color: scheme.borderList),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  breed.name ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    'More...',
                    style: TextStyle(
                      fontSize: 16,
                      color: scheme.blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Hero(
              tag: breed.id ?? 'tag',
              child: CustomNetworkImage(
                imageUrl: images?.first.url ?? '',
                height: heightCard * 0.7,
                width: MediaQuery.of(context).size.width - 64,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Origin: ${breed.origin ?? 'umknown'}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              children: breed.temperament
                      ?.split(',')
                      .map(
                        (temperament) => TagTemperament(text: temperament),
                      )
                      .toList() ??
                  [],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showDetail(BuildContext context) {
    final page = DetailPage(breed: breed);
    Navigator.of(context).push(
      Platform.isIOS
          ? CupertinoPageRoute(builder: (_) => page)
          : MaterialPageRoute(builder: (_) => page),
    );
  }
}
