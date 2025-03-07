// To parse this JSON data, do
//
//     final breedImage = breedImageFromJson(jsonString);

import 'dart:convert';

BreedImage breedImageFromJson(String str) =>
    BreedImage.fromJson(json.decode(str));

String breedImageToJson(BreedImage data) => json.encode(data.toJson());

class BreedImage {
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  BreedImage({
    this.id,
    this.url,
    this.width,
    this.height,
  });

  BreedImage copyWith({
    String? id,
    String? url,
    int? width,
    int? height,
  }) =>
      BreedImage(
        id: id ?? this.id,
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory BreedImage.fromJson(Map<String, dynamic> json) => BreedImage(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
