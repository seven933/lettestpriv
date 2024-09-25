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
  factory CardBrandModel.fromMap(Map<String, dynamic> map) {
    return CardBrandModel(
      code: map['code'],  // A chave 'code' deve estar dentro do próprio Map
      name: map['name'],
      image: map['image'],
      status: map['status'] != null ? (map['status'] as num).toInt() : null,
      debitStatus: map['debit_status'] != null ? (map['debit_status'] as num).toInt() : null,
      creditStatus: map['credit_status'] != null ? (map['credit_status'] as num).toInt() : null,
    );
  }

  // Método que converte um JSON string em um CardBrandModel
  factory CardBrandModel.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return CardBrandModel.fromMap(map);
  }

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
    final Map<String, dynamic> map = value is Map<String, dynamic> ? value : {};
    map['code'] = key;  // Adicionar o código da bandeira
    cardBrands.add(CardBrandModel.fromMap(map));
  });

  return cardBrands;
}
