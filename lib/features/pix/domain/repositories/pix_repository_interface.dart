import 'package:sixam_mart/features/pix/domain/models/create_pix_payment_model.dart';
import 'package:sixam_mart/features/pix/domain/models/pix_payment_model.dart';
import 'package:sixam_mart/interfaces/repository_interface.dart';

abstract class PixRepositoryInterface extends RepositoryInterface{
	
	/**
	* @author Giovane Neves
	* Cria uma cobrança pix com os dados passados por parâmetro
	*/
	Future<String> createPixPayment(String data);
	Future<void> createCardPayment(String data);
	
} 