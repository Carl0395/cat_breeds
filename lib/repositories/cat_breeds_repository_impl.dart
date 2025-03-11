import 'dart:convert';

import 'package:cat_breeds/models/breed.dart';
import 'package:cat_breeds/models/breed_image.dart';
import 'package:cat_breeds/repositories/cat_breeds_repository.dart';
import 'package:cat_breeds/repositories/routes.dart';
import 'package:cat_breeds/repositories/util/api_base_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CatBreedsRepositoryImpl implements CatBreedsRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  @override
  Future<List<Breed>> getBreeds({CancelToken? cancelToken}) async {
    final response = await _helper.get(
      Routes.breeds,
      cancelToken: cancelToken,
    );

    final data = response.runtimeType == String
        ? json.decode(response.toString())
        : response;
    List<Breed> breeds = [];
    data.forEach((breed) {
      breeds.add(Breed.fromJson(breed));
    });
    return breeds;
  }

  @override
  Future<List<BreedImage>> getBreedImages({
    required String idBreed,
    CancelToken? cancelToken,
  }) async {
    final apiKey = dotenv.env['API_KEY'];

    final response = await _helper.get(
      '${Routes.breedImages}?limit=10&breed_ids=$idBreed&api_key=$apiKey',
      cancelToken: cancelToken,
    );

    final data = response.runtimeType == String
        ? json.decode(response.toString())
        : response;
    List<BreedImage> images = [];
    data.forEach((image) {
      images.add(BreedImage.fromJson(image));
    });
    return images;
  }
}
