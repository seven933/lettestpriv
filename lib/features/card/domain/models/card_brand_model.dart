import 'dart:convert';

class CardBrandModel {
  String? code;
  String? name;
  String? image;
  List<String>? type;

  CardBrandModel({
    this.code,
    this.name,
    this.image,
    this.type,
  });

  // Método que converte um Map em um CardBrandModel
  factory CardBrandModel.fromJson(Map<String, dynamic> json) {
    return CardBrandModel(
      code: json['code'],
      name: json['name'],
      image: json['image'],
      type: List<String>.from(json['type'] ?? []), // Garantindo que o 'type' seja uma lista de strings
    );
  }

  // Método que converte o modelo para Map
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'image': image,
      'type': type,
    };
  }
}
