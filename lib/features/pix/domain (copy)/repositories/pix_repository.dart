import 'package:sixam_mart/features/pix/domain/repositories/pix_repository_interface.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/pix/domain/models/pix_payment_model.dart';
import 'package:sixam_mart/features/pix/domain/models/create_pix_payment_model.dart';
import 'dart:convert';
import 'package:get/get_connect/connect.dart';

class PixRepository implements PixRepositoryInterface{
	

	final ApiClient apiClient;
  	final SharedPreferences sharedPreferences;
	
	PixRepository({
	    required this.apiClient,
	    required this.sharedPreferences,
	});

	String extractPixKey(String responseBodyString) {
	    String startToken = 'pix_copia_e_cola: ';
	    int startIndex = responseBodyString.indexOf(startToken) + startToken.length;
	    int endIndex = responseBodyString.indexOf('}', startIndex);  // Ajustado para procurar o final da chave
	    if (endIndex == -1) {
	        endIndex = responseBodyString.length;
	    }
	    return responseBodyString.substring(startIndex, endIndex).trim();
	}

	/**
	* @author Giovane Neves
	*
	* Cria uma cobrança pix com base nos dados passados por parâmetro
	* e retorna uma chave aleatório para receber o pagamento.
	*/
	@override
	Future<String> createPixPayment(String data) async{

		Response response = await apiClient.postData(AppConstants.pixPayment, jsonDecode(data));
		if(response.statusCode == 200){
			
			//Map<String, dynamic> responseData = jsonDecode(response.body);
			String responseBodyString = response.body.toString();
			//String pixKey = extractPixKey(responseBodyString);
			//return PixPaymentModel(randomPixKey: 'pixKey');
			return extractPixKey(responseBodyString); 
		//	Map<String, dynamic> responseData = json.decode(response.body);
		//	PixPaymentModel pixPaymentModel = PixPaymentModel.fromJson(responseData);

		//	return pixPaymentModel;

		} else {

			throw Exception('Failed to create pix payment');

		}

	}

	@override
	Future<void> createCardPayment(String data) async{

		Response response = await apiClient.postData(AppConstants.cardPayment, jsonDecode(data));

		if(response.statusCode == 200){

		}
	}

	@override
	Future add(value) {
	    throw UnimplementedError();
	}

	@override
	Future delete(int? id) {
	    throw UnimplementedError();
	}

	@override
	Future get(String? id) {
	  throw UnimplementedError();
	}

	@override
	Future<List<PixPaymentModel>> getList({int? offset}) {
	    throw UnimplementedError();
	}

	@override
	Future update(Map<String, dynamic> body, int? id) {
	    throw UnimplementedError();
	}

}