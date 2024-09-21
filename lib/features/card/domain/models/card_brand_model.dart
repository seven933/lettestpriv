import 'dart:convert';

class CardBrandModel {
  String? code;
  String? name;
  String? image;

  CardBrandModel({this.code, this.name, this.image});

  factory CardBrandModel.fromMap(Map<String, dynamic> map) {
    return CardBrandModel(
      code: map['code'],
      name: map['name'],
      image: map['image'],
    );
  }

  factory CardBrandModel.fromJson(String source) => CardBrandModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());
}
