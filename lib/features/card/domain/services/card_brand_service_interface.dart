import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

abstract class CardBrandServiceInterface{

	Future<List<CardBrandModel?>> getAcceptedCardBrandList();

}