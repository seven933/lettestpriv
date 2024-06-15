
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/pix/domain/services/pix_service_interface.dart';
import 'package:sixam_mart/features/pix/domain/models/pix_payment_model.dart';

class PixController extends GetxController implements GetxService{
 
	final PixServiceInterface pixServiceInterface;

	PixController({required this.pixServiceInterface});

	//String _pixKey = '.';
	//String get pixKey => _pixKey;


	Future<String> createPixPayment(String data) async{

		//PixPaymentModel pixPaymentModel 
		String pixKey = await pixServiceInterface.createPixPayment(data); 

		//_pixKey = pixPaymentModel.randomPixKey;
		return pixKey;
		update();
		//return "chave de teste";

	}

}