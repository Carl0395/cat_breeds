import 'package:cat_breeds/controllers/breeds_controller.dart';
import 'package:cat_breeds/repositories/cat_breeds_repository_impl.dart';
import 'package:cat_breeds/ui/pages/home_page/widgets/breed_card.dart';
import 'package:cat_breeds/ui/pages/home_page/widgets/loading_card.dart';
import 'package:cat_breeds/ui/pages/home_page/widgets/loading_list.dart';
import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:cat_breeds/ui/widgets/custom_appbar.dart';
import 'package:cat_breeds/ui/widgets/search.dart';
import 'package:cat_breeds/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final breedsController = Get.put(BreedsController(CatBreedsRepositoryImpl()));

  @override
  void initState() {
    super.initState();

    breedsController.getBreeds();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return Scaffold(
      backgroundColor: scheme.backgroundColor,
      appBar: CustomAppBar(
        title: "Catbreeds",
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Search(
              hintText: "Search by breed",
              controller: searchController,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GetBuilder<BreedsController>(builder: (ctrl) {
              if (ctrl.breeds == null) {
                return LoadingList();
              }

              return ListView.builder(
                  itemCount: ctrl.breeds!.length,
                  itemBuilder: (_, index) {
                    debugLog('index $index');
                    final breed = ctrl.breeds![index];
                    ctrl.loadPhotosByBreedId(id: breed.id);
                    return BreedCard(breed: breed);
                  });
            }),
          ),
        ],
      ),
    );
  }
}
