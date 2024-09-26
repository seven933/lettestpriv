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
      code: code,
      name: map['name'],
      image: map['image'],
      status: map['status'] != null ? (map['status'] as num).toInt() : null,
      debitStatus: map['debit_status'] != null ? (map['debit_status'] as num).toInt() : null,
      creditStatus: map['credit_status'] != null ? (map['credit_status'] as num).toInt() : null,
    );
  }

  // Novo método fromJson
  factory CardBrandModel.fromJson(Map<String, dynamic> json) {
    return CardBrandModel(
      code: json['code'],
      name: json['name'],
      image: json['image'],
      status: json['status'] != null ? (json['status'] as num).toInt() : null,
      debitStatus: json['debit_status'] != null ? (json['debit_status'] as num).toInt() : null,
      creditStatus: json['credit_status'] != null ? (json['credit_status'] as num).toInt() : null,
    );
  }

  // Método que converte o modelo para Map
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
