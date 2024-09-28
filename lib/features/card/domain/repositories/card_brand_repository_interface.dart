import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

abstract class CardBrandRepositoryInterface{

	Future<List<CardBrandModel?>> getAcceptedCardBrandList();
	Future<List<CardBrandModel>> getAcceptedCardBrandListByStoreId(int storeId);
}