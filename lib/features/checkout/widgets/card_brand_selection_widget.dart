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
                  return Column(
                    children: [
                      Image.network(brand.image ?? '', width: 40, height: 40),
                      Text(brand.name ?? 'Unknown'),
                    ],
                  );
                }).toList(),
              );
            },
        )
        : const SizedBox();
  }

  // Função para garantir o retorno de uma lista de CardBrandModel
  Future<List<CardBrandModel>> _getCardBrandList() async {
    
    List<dynamic> rawList = await Get.find<CardBrandController>().getAcceptedCardBrandListByStoreId(storeId);

    // Verificação se todos os itens são do tipo Map<String, dynamic>
    return rawList.where((item) => item is Map<String, dynamic>).map((item) {
      return CardBrandModel.fromJson(item as Map<String, dynamic>);
    }).toList();

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
