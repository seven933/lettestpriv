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

  const CardSelectionWidget({Key? key, required this.checkoutController, required this.type, required this.storeId}) : super(key: key);

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
                children: snapshot.data!.map((brand) {
                  return GestureDetector(
                    onTap: () {
                      Get.find<CheckoutController>().setCardBrand(brand);
                    },
                    child: Obx(() {
                      bool isSelected = checkoutController.selectedCardBrand?.code == brand.code;

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.transparent,
                            width: isSelected ? 2 : 0,
                          ),
                          borderRadius: BorderRadius.circular(8),
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
                  );
                }).toList(),
              );
            },
        )
        : const SizedBox();
  }

  Widget _buildCardOption(BuildContext context, String imageUrl, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          // Exibe a imagem da bandeira do cartão
          Image.network(imageUrl, width: 40, height: 40, errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.credit_card, size: 40); // Ícone padrão se houver erro ao carregar a imagem
          }),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                ),
          ),
        ],
      ),
    );
  }
}
