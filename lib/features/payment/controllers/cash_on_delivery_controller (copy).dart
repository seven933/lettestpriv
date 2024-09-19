import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CashOnDeliveryController extends GetxController implements GetxService{

	double _changeAmount = 0.0;
	double get changeAmount => _changeAmount;

	void setChangeAmount(double amount){

		_changeAmount = amount;
		update();
 
	}
}