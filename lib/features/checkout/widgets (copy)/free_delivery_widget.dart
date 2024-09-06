import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:sixam_mart/common/controllers/theme_controller.dart';

/**
* @author Giovane Neves
* Widget exibido na tela de checkout que informa quanto 
* falta para o usuário atingir o valor mínimo para a entrega grátis.
*/
class FreeDeliveryWidget extends StatelessWidget {

  final double minimumValue;
  final double currentValue;

  FreeDeliveryWidget({required this.minimumValue, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    
    double remainingValue = minimumValue - currentValue;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        remainingValue > 0
            ? 'Faltam apenas R\$${remainingValue.toStringAsFixed(2)} para entrega grátis'
            : 'you_have_reached_the_minimum_amount_for_free_delivery'.tr,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}