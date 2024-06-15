import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/card/domain/models/card_model.dart';
import 'package:sixam_mart/features/card/domain/services/card_service_interface.dart';

class CardController extends GetxController implements GetxService {
  final CardServiceInterface cardService;

  CardController({required this.cardService});

  String _type = 'credit'.tr;

  bool get isCredit => _type == 'credit'.tr;

  List<CardModel>? _accountCardList;
  List<CardModel>? get accountCardList => _accountCardList;

  late List<CardModel> _allAccountCardList;

  void setType(String type) {
    _type = type;

    update();
  }

  Future<void> addCard(CardModel card) async {
    await cardService.addCard(card);

    await getAccountCardList();
  }

  Future<void> getAccountCardList() async {
    List<CardModel>? cardList = await cardService.getAccountCardList();

    if (cardList != null) {
      _accountCardList = [];
      _allAccountCardList = [];
      _accountCardList!.addAll(cardList);
      _allAccountCardList.addAll(cardList);
    }

    update();
  }
}
