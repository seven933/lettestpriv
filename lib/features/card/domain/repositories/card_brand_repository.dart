import 'package:get/get.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/card/domain/repositories/card_brand_repository_interface.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

/*
*
* @author Giovane Neves
*/
class CardBrandRepository implements CardBrandRepositoryInterface {

  final ApiClient apiClient;

  CardBrandRepository({required this.apiClient});

  @override
  Future<List<CardBrandModel?>> getAcceptedCardBrandList() async {
    List<CardBrandModel?> cardBrandList = [];

    Response response = await apiClient.getData(AppConstants.cardBrandListUri);

    if (response.statusCode == 200 && response.body != null) {
      // Acessando o array "card_brands"
      List<dynamic> body = response.body['card_brands'];

      // Mapeando a lista para o modelo
      cardBrandList = body.map((item) {
        return CardBrandModel.fromJson(item); // Criando o modelo com o JSON correto
      }).toList();
    }

    return cardBrandList.whereType<CardBrandModel>().toList();
  }

  	@Override
	Future<List<CardBrandModel>> getAcceptedCardBrandListByStoreId(int storeId) async {
	  List<CardBrandModel> cardBrandList = [];

	  Response response = await apiClient.getData('${AppConstants.storeCardBrandListUri}$storeId');

	  if (response.statusCode == 200 && response.body != null) {
	    // Verifique se a chave "card_brands" existe e é uma lista
	    if (response.body['card_brands'] != null && response.body['card_brands'] is List) {
	      List<dynamic> body = response.body['card_brands'];

	      // Mapeia cada item da lista para o modelo CardBrandModel
	      cardBrandList = body.map((item) {
	        return CardBrandModel.fromJson(item as Map<String, dynamic>); // Mapear JSON para CardBrandModel
	      }).toList();
	    } else {
	      // Caso a chave "card_brands" não seja uma lista, adicionar log para depuração
	      print('Expected a list in "card_brands", but got: ${response.body['card_brands']}');
	    }
	  }

	  return cardBrandList; // Retorna a lista de CardBrandModel
	}

}
