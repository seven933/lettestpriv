import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';
import 'package:sixam_mart/features/card/controllers/card_brand_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';

class CardSelectionWidget extends StatelessWidget {
  final CheckoutController checkoutController;
  final int type;
  final int storeId;

  const CardSelectionWidget({
    Key? key,
    required this.checkoutController,
    required this.type,
    required this.storeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (checkoutController.paymentMethodIndex == 3 || checkoutController.paymentMethodIndex == 4)
        ? FutureBuilder<List<CardBrandModel>>(
            future: Get.find<CardBrandController>().getAcceptedCardBrandListByStoreId(storeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No card brands available');
              }

              return Wrap(
                spacing: 10,
                children: snapshot.data!.map((brand) {
                  bool isSelected = checkoutController.selectedCardBrand == brand.code;

                  return GestureDetector(
                    onTap: () {
                      checkoutController.setCardBrand(brand?.code);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Image.network(
                            brand.image ?? '',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.credit_card, size: 40);
                            },
                          ),
                          const SizedBox(height: 5),
                          Text(
                            brand.name ?? 'Unknown',
                            style: TextStyle(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )
        : const SizedBox();
  }
}


