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

  factory CardBrandModel.fromJson(Map<String, dynamic> json) {
    return CardBrandModel(
      code: json['code'],
      name: json['name'],
      image: json['image'],
      type: List<String>.from(json['type'] ?? []),
    );
  }

  Map<String, dynamic> toMap(){

    return {
      
      'code' : code,
      'name' : name,
      'expiration_date' : expirationDate,
      'image' : image,
      'type' : type
    };

  }
}
