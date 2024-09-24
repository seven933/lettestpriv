import 'package:get/get.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_brand_repository_interface.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

/*
*
* @author Giovane Neves
*/
class CardBrandRepository implements CardBrandRepositoryInterface{

	final ApiClient apiClient;

	CardBrandRepository({required this.apiClient});


	@override
	Future<List<CardBrandModel?>> getAcceptedCardBrandList() async {
    	
    	 List<CardBrandModel?> cardBrandList = [];

	    Response response = await apiClient.getData(AppConstants.cardBrandListUri);

	    if(response.statusCode == 200 && response.body != null) {
	      
	      List<dynamic> body = response.body;
	      cardBrandList = body.entries.map((entry) => CardBrandModel.fromMap(entry.key, entry.value)).toList();;
	    
	    }

	    return cardBrandList;
    
  	}

  	@override
  	Future<List<CardBrandModel?>> getAcceptedCardBrandListByStoreId(int storeId) async{

  		List<CardBrandModel?> cardBrandList = [];

  		Response response = await apiClient.getData('${AppConstants.storeCardBrandListUri}$storeId');

  		if(response.statusCode == 200 && response.body != null){

  			List<dynamic> body = response.body;
	      	cardBrandList = body.entries.map((entry) => CardBrandModel.fromMap(entry.key, entry.value)).toList();;

  		}

  		return cardBrandList;
  	}

}