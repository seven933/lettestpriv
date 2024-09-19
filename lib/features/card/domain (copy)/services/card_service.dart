import 'package:sixam_mart/features/card/domain/models/card_model.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_repository_interface.dart';
import 'package:sixam_mart/features/card/domain/services/card_service_interface.dart';

class CardService implements CardServiceInterface{
  
  final CardRepositoryInterface cardRepositoryInterface;

  CardService({required this.cardRepositoryInterface});

  @override
  Future<List<CardModel>> getAccountCardList() async {
    
    return await cardRepositoryInterface.getAccountCards();

  }

  @override
  Future<void> addCard(CardModel card) async{

    await cardRepositoryInterface.saveAccountCard(card);

  }

}