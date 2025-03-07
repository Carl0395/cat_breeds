import 'dart:async';

import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/models/breed_image.dart';
import 'package:cat_breeds/repositories/cat_breeds_repository.dart';
import 'package:cat_breeds/repositories/util/custom_exceptions.dart';
import 'package:cat_breeds/util/util.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BreedsController extends GetxController {
  BreedsController(this.catBreedsRepository);
  final CatBreedsRepository catBreedsRepository;

  List<Breed>? allBreeds;
  List<Breed>? breeds;
  Map<String, List<BreedImage>> photosByBreed = {};
  CancelToken cancelTokenBreeds = CancelToken();
  CancelToken cancelTokenPhotos = CancelToken();
  Timer? delayLoadImages;

  Future<void> getBreeds({
    void Function(CustomException e)? onError,
  }) async {
    cancelTokenBreeds.cancel();
    cancelTokenBreeds = CancelToken();
    delayLoadImages?.cancel();

    delayLoadImages = Timer(Duration(milliseconds: 500), () async {
      try {
        breeds = await catBreedsRepository.getBreeds(
          cancelToken: cancelTokenBreeds,
        );
        allBreeds = breeds;
        update();
      } catch (e, stack) {
        onError?.call(UnknownException(e.toString()));
        debugLog(e, stack);
        // Notificación a sentry o diagnostico de errores
      }
    });
  }

  void searchByQuery(String text) {
    if (text.isEmpty) {
      breeds = allBreeds;
      update();
      return;
    }
    breeds = allBreeds
        ?.where((breed) =>
            (breed.name ?? '').toLowerCase().contains(text.toLowerCase()))
        .toList();
    update();
  }

  Future<void> loadPhotosByBreedId({
    required String? id,
    void Function(CustomException e)? onError,
  }) async {
    if (id == null) return;
    if (photosByBreed[id] != null) return;
    cancelTokenBreeds.cancel();
    cancelTokenPhotos = CancelToken();

    try {
      photosByBreed[id] = await catBreedsRepository.getBreedImages(
        idBreed: id,
        cancelToken: cancelTokenPhotos,
      );
      update();
    } on AbortException {
      debugLog('se cancelo la petición');
    } catch (e, stack) {
      onError?.call(UnknownException(e.toString()));
      debugLog(e, stack);
      // Notificación a sentry o diagnostico de errores
    }
  }

  @override
  void dispose() {
    cancelTokenBreeds.cancel();
    cancelTokenPhotos.cancel();
    super.dispose();
  }
}
