import 'dart:convert';

class CardModel{

  String nickname;
  String cardNumber;
  String expirationDate;
  int cvv;
  String type;
  String brand; 

  CardModel({ required this.nickname, required this.cardNumber, required this.expirationDate, required this.cvv, required this.type, required this.brand});

  factory CardModel.fromMap(Map<String, dynamic> map){

    return CardModel(

      nickname: map['nickname'],
      cardNumber: map['card_number'],
      expirationDate: map['expiration_date'],
      cvv: map['cvv'],
      type: map['type'],
      brand: map['brand'],
      
    );

  }
  
  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap(){

    return {
      
      'nickname' : nickname,
      'card_number' : cardNumber,
      'expiration_date' : expirationDate,
      'cvv' : cvv,
      'type' : type,
      'brand' : brand,
    };

  }
  
  String toJson() => json.encode(toMap());

}