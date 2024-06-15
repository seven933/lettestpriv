import 'package:sixam_mart/features/pix/domain/services/pix_service_interface.dart';
import 'package:sixam_mart/features/pix/domain/models/pix_payment_model.dart';
import 'package:sixam_mart/features/pix/domain/repositories/pix_repository_interface.dart';

class PixService implements PixServiceInterface{

	final PixRepositoryInterface pixRepositoryInterface;

	PixService({required this.pixRepositoryInterface});

	/**
	* @author Giovane Neves
	* Cria uma cobrança pix com os dados passados por parâmetro
	*/
	@override
	Future<String> createPixPayment(String data) async {

		return await pixRepositoryInterface.createPixPayment(data);

	}
}