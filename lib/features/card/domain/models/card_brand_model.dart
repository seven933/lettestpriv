import 'dart:convert';

class CardBrandModel {
  String? code;
  String? name;
  String? image;
  int? status;
  int? debitStatus;
  int? creditStatus;

  CardBrandModel({
    this.code,
    this.name,
    this.image,
    this.status,
    this.debitStatus,
    this.creditStatus,
  });

  // Método que converte um Map em um CardBrandModel
  factory CardBrandModel.fromMap(String code, Map<String, dynamic> map) {
    return CardBrandModel(
      code: code,  // O código da bandeira (visa, mastercard, etc.) vem da chave
      name: map['name'],
      image: map['image'],
      status: map['status'],
      debitStatus: map['debit_status'],
      creditStatus: map['credit_status'],
    );
  }

  // Método que converte um JSON string em um Map e chama o fromMap
  factory CardBrandModel.fromJson(String source) => CardBrandModel.fromMap(json.decode(source)['code'], json.decode(source));

  // Método que converte o CardBrandModel de volta para Map
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'image': image,
      'status': status,
      'debit_status': debitStatus,
      'credit_status': creditStatus,
    };
  }

  // Método que converte o modelo para JSON string
  String toJson() => json.encode(toMap());
}

// Função que recebe o dicionário JSON e converte para uma lista de CardBrandModel
List<CardBrandModel> parseCardBrands(Map<String, dynamic> data) {
  List<CardBrandModel> cardBrands = [];
  
  // Iterar sobre as chaves e valores do mapa
  data.forEach((key, value) {
    cardBrands.add(CardBrandModel.fromMap(key, value));
  });

  return cardBrands;
}
