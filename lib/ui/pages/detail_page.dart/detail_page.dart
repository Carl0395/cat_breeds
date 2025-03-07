import 'package:cat_breeds/controllers/breeds_controller.dart';
import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/ui/pages/detail_page.dart/widgets/attribute_box.dart';
import 'package:cat_breeds/ui/pages/detail_page.dart/widgets/option_label.dart';
import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:cat_breeds/ui/widgets/custom_appbar.dart';
import 'package:cat_breeds/ui/widgets/custom_network_image.dart';
import 'package:cat_breeds/ui/widgets/pager_dot.dart';
import 'package:cat_breeds/ui/widgets/rating_star.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    final ctrl = Get.find<BreedsController>();
    final photos = ctrl.photosByBreed[breed.id];
    return Scaffold(
      backgroundColor: scheme.backgroundColor,
      appBar: CustomAppBar(
        title: breed.name ?? '',
        leadingTap: () => Navigator.of(context).pop(),
        radius: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
              child: Hero(
                tag: breed.id ?? 'tag',
                child: Material(
                  child: PagerDot(
                    height: MediaQuery.of(context).size.height * 0.5,
                    itemBuilder: (_, index) {
                      final photo = photos?[index].url;
                      return CustomNetworkImage(
                        imageUrl: photo ?? '',
                        height: 230,
                        radius: 0,
                        width: MediaQuery.of(context).size.width - 64,
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: photos?.length ?? 0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                thickness: 6,
                radius: Radius.circular(4),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        scrollDirection: Axis.horizontal,
                        children: [
                          AttributeBox(
                            label: 'Origin',
                            value: '${breed.origin}',
                          ),
                          SizedBox(width: 10),
                          AttributeBox(
                            label: 'Life Span',
                            value: '${breed.lifeSpan} years',
                          ),
                          SizedBox(width: 10),
                          AttributeBox(
                            label: 'Weight',
                            value:
                                '${breed.weight?.metric?.replaceFirst(' - ', '-')} KG',
                          ),
                          SizedBox(width: 10),
                          AttributeBox(
                            label: 'Adaptability',
                            value: '${breed.adaptability}',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      breed.description ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 5),
                    OptionLabel(
                      label: 'Temperament',
                      value: breed.temperament,
                    ),
                    SizedBox(height: 5),
                    RatingStar(
                      label: 'Child Friendly',
                      rating: breed.childFriendly ?? 0,
                      color: scheme.secondaryColor,
                    ),
                    RatingStar(
                      label: 'Energy Level',
                      rating: breed.energyLevel ?? 0,
                      color: scheme.secondaryColor,
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
