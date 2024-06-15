import 'package:sixam_mart/features/card/domain/models/card_model.dart';

abstract class CardServiceInterface {

  Future<List<CardModel>> getAccountCardList();
  Future<void> addCard(CardModel card); 
}