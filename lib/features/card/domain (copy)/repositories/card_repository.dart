import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/features/card/domain/models/card_model.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_repository_interface.dart';
import 'package:sixam_mart/util/app_constants.dart';

class CardRepository implements CardRepositoryInterface{

  final SharedPreferences sharedPreferences;

  CardRepository({required this.sharedPreferences});

  @override
  Future<List<CardModel>> getAccountCards() async {
    
    final cardList = sharedPreferences.getStringList(AppConstants.accountCardList) ?? [];
    return cardList.map((json) => CardModel.fromJson(json)).toList();

  }

  @override
  Future<void> saveAccountCard(CardModel card) async{

    List<CardModel> cards = await getAccountCards();

    cards.add(card);

    _saveList(cards);

  }

  @override
  Future<void> deleteAccountCard(String nickname) async{

    List<CardModel> cards = await getAccountCards();

    if(cards != null){

      cards.removeWhere((card) => card.nickname == nickname);

    }
    
    _saveList(cards);

  }

  Future<void> _saveList(List<CardModel> cards) async{

    final jsonCardList = cards.map((c) => c.toJson()).toList();

    await sharedPreferences.setStringList(AppConstants.accountCardList, jsonCardList);

  }

}