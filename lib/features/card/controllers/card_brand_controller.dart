import 'package:get/get.dart';
import 'package:sixam_mart/features/card/domain/services/card_brand_service_interface.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

/*
* @author Giovane Neves
*/
class CardBrandController extends GetxController implements GetxService{

	final CardBrandServiceInterface cardBrandServiceInterface;

	CardBrandController({required this.cardBrandServiceInterface});

	List<CardBrandModel?> _acceptedCardBrandList = [];
	List<CardBrandModel?> get acceptedCardBrandList => _acceptedCardBrandList;

	Future<List<CardBrandModel?>> getAcceptedCardBrandList() async {
	    
	    _acceptedCardBrandList = await cardBrandServiceInterface.getAcceptedCardBrandList();
	    update();
	    return _acceptedCardBrandList; 
	
	}

	Future<List<CardBrandModel>> getAcceptedCardBrandListByStoreId(int storeId){
	
		 return cardBrandServiceInterface.getAcceptedCardBrandListByStoreId(storeId);
	
	}


}