import 'package:sixam_mart/features/pix/domain/models/pix_payment_model.dart';

abstract class PixServiceInterface{
	
	/**
	* @author Giovane Neves
	* Cria uma cobrança pix com os dados passados por parâmetro
	*/
	Future<String> createPixPayment(String data);
	Future<void> createCardPayment(String data);

}