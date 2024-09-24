import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

/*
* @author Giovane Neves
*/
abstract class CardBrandServiceInterface{

	Future<List<CardBrandModel?>> getAcceptedCardBrandList();
	Future<List<CardBrandModel?>> getAcceptedCardBrandListByStoreId(int storeId);

}