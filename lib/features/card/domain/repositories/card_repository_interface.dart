import 'package:sixam_mart/features/card/domain/models/card_model.dart';

abstract class CardRepositoryInterface{

  Future<List<CardModel>> getAccountCards();
  Future<void> saveAccountCard(CardModel card);
  Future<void> deleteAccountCard(String nickname);

}