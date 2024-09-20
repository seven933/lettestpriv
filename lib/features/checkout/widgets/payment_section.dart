import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_method_bottom_sheet.dart';
import 'package:sixam_mart/features/checkout/widgets/card_brand_selection_widget.dart';

/**
*
*/
class PaymentSection extends StatelessWidget {

  final int? storeId;
  final bool isCashOnDeliveryActive;
  final bool isDigitalPaymentActive;
  final bool isWalletActive;
  final double total;
  final CheckoutController checkoutController;
  final bool isOfflinePaymentActive;

  const PaymentSection({super.key, this.storeId, required this.isCashOnDeliveryActive, required this.isDigitalPaymentActive,
    required this.isWalletActive, required this.total, required this.checkoutController, required this.isOfflinePaymentActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(storeId != null ? 'payment_method'.tr : 'choose_payment_method'.tr, style: robotoMedium),

        storeId == null && !ResponsiveHelper.isDesktop(context) ? InkWell(
          onTap: (){
            Get.bottomSheet(
              PaymentMethodBottomSheet(
                isCashOnDeliveryActive: isCashOnDeliveryActive, isDigitalPaymentActive: isDigitalPaymentActive,
                isWalletActive: isWalletActive, storeId: storeId, totalPrice: total, isOfflinePaymentActive: isOfflinePaymentActive,
              ),
              backgroundColor: Colors.transparent, isScrollControlled: true,
            );

          },
          child: Image.asset(Images.paymentSelect, height: 34, width: 54),
        ) : const SizedBox(),
      ]),

      const Divider(),

      Container(
        decoration: const BoxDecoration(),
        padding: EdgeInsets.zero,
        child: storeId != null ? checkoutController.paymentMethodIndex == 0 ? Row(children: [
          Image.asset(Images.cash , width: 20, height: 20,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text('cash_on_delivery'.tr,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
          )),

          Text(
            PriceConverter.convertPrice(total), textDirection: TextDirection.ltr,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
          )

        ]) : const SizedBox() : InkWell(

          onTap: () {
            
          },

          child: Row(children: [
            checkoutController.paymentMethodIndex != -1 ? Image.asset(
              checkoutController.paymentMethodIndex == 0 ? Images.cash
                  : checkoutController.paymentMethodIndex == 1 ? Images.wallet
                  : checkoutController.paymentMethodIndex == 2 ? Images.pix 
                  : (checkoutController.paymentMethodIndex == 3 || checkoutController.paymentMethodIndex == 4) ? Images.cards
                  : Images.cash,
              width: 20, 
              height: 20,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ) : Icon(
              !ResponsiveHelper.isDesktop(context) ? Icons.wallet_outlined : Icons.add_circle_outline_sharp,
              size: 18, color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(
              child: Row(children: [
                Text(
                  checkoutController.paymentMethodIndex == 0 ? 'cash_on_delivery'.tr
                      : checkoutController.paymentMethodIndex == 1 ? 'wallet_payment'.tr
                      : checkoutController.paymentMethodIndex == 2 ? 'pix_on_delivery'.tr
                      : checkoutController.paymentMethodIndex == 3 ? 'credit_card_on_delivery'.tr 
                      : checkoutController.paymentMethodIndex == 4 ? 'debit_card_on_delivery'.tr
                      : checkoutController.paymentMethodIndex == 5 ? 'pix'.tr

                      : !ResponsiveHelper.isDesktop(context) ? 'select_payment_method'.tr : 'add_payment_method'.tr,
                  
                  style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).disabledColor
                        : checkoutController.paymentMethodIndex == -1 ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                ),
                checkoutController.paymentMethodIndex == 3 || checkoutController.paymentMethodIndex == 4 ? Image.asset(
                  Images.mastercard,
                  width: 25,
                  height: 25,
                ) : const SizedBox(),

                checkoutController.paymentMethodIndex == -1 && !ResponsiveHelper.isDesktop(context) ? Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                  child: Icon(Icons.error, size: 16, color: Theme.of(context).colorScheme.error),
                ) : const SizedBox(),
              ])
            ),
            const SizedBox(),
            checkoutController.paymentMethodIndex == 3 || checkoutController.paymentMethodIndex == 4
              ? CardSelectionWidget(checkoutController: checkoutController)
              : const SizedBox(),

            checkoutController.paymentMethodIndex != -1 ? PriceConverter.convertAnimationPrice(
              checkoutController.viewTotalPrice,
              textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
            ) : const SizedBox(),

            SizedBox(width: 0),
            const SizedBox(),
          ]),
        ),
      ),

    ]);
  }
}
