import 'package:get/get.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_brand_repository_interface.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

class CardBrandRepository implements CardBrandRepositoryInterface{

	final ApiClient apiClient;

	CardBrandRepository({required this.apiClient});


	@override
	Future<List<CardBrandModel?>> getAcceptedCardBrandList() async {
    	
    	CardBrandModel? CardBrandModel;

    	Response response = await apiClient.getData(AppConstants.cardBrandListUri);

    	if(response.statusCode == 200){
    		cardBrandModel = CardBrandModel.fromJson(response.body); 
    	}

    	return cardBrandModel;
    
  	}

}