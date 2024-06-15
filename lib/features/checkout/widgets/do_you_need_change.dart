import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:sixam_mart/common/widgets/custom_button.dart';
 
class DoYouNeedChange extends StatelessWidget {

  final Function(bool) onSelection;

  DoYouNeedChange({required this.onSelection});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('do_you_need_change'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: CustomButton(
                    isLoading: false,
                    buttonText: 'yes'.tr,
                    onPressed: () {
                      Get.back();
                    },
                  ),
              ),
              SizedBox(height: 10), // Espaço de 10 pixels entre os botões
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: CustomButton(
                    isLoading: false,
                    buttonText: 'yes'.tr,
                    onPressed: () {
                      Get.back();
                    },
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}