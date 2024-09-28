import 'package:sixam_mart/features/card/domain/services/card_brand_service_interface.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_brand_repository_interface.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

/*
* @author Giovane Neves
*/
class CardBrandService implements CardBrandServiceInterface{

	final CardBrandRepositoryInterface cardBrandRepositoryInterface;

	CardBrandService({required this.cardBrandRepositoryInterface});

	@override
	Future<List<CardBrandModel?>> getAcceptedCardBrandList() async{

		return await cardBrandRepositoryInterface.getAcceptedCardBrandList();

	}

	@override
	Future<List<CardBrandModel>> getAcceptedCardBrandListByStoreId(int storeId) async{

		return await cardBrandRepositoryInterface.getAcceptedCardBrandListByStoreId(storeId);

	}
}