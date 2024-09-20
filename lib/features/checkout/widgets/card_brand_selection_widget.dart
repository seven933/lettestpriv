import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/dimensions.dart';

class CardSelectionWidget extends StatelessWidget {
  final CheckoutController checkoutController;

  const CardSelectionWidget({Key? key, required this.checkoutController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (checkoutController.paymentMethodIndex == 3 || checkoutController.paymentMethodIndex == 4) 
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Card Type', 
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCardOption(Images.mastercard, 'Mastercard', () {
                  // checkoutController.selectCard('Mastercard');
                }),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                _buildCardOption(Images.visa, 'Visa', () {
                  // checkoutController.selectCard('Visa');
                }),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                _buildCardOption(Images.mastercard, 'Amex', () {
                  // checkoutController.selectCard('Amex');
                }),
              ],
            ),
          ],
        )
      : const SizedBox();
  }

  Widget _buildCardOption(String image, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, width: 40, height: 40),
          Text(
            label, 
            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
          ),
        ],
      ),
    );
  }
}
