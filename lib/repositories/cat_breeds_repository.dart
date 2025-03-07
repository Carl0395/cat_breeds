import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/models/breed_image.dart';
import 'package:dio/dio.dart';

abstract class CatBreedsRepository {
  Future<List<Breed>> getBreeds({
    CancelToken? cancelToken,
  });

  Future<List<BreedImage>> getBreedImages({
    required String idBreed,
    CancelToken? cancelToken,
  });
}
