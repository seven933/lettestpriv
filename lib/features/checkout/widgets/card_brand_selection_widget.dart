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
            future: _getCardBrandList(),  // Atualizando para usar o método que garante o tipo correto
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Mostra um loading enquanto carrega
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No card brands available');
              }

              List<CardBrandModel> cardBrandList = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'select_card_brand'.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Wrap(
                    spacing: Dimensions.paddingSizeSmall,
                    runSpacing: Dimensions.paddingSizeSmall,
                    children: cardBrandList.map((brand) {
                      return _buildCardOption(
                        context,
                        brand.image ?? '', // Use o caminho da imagem da API
                        brand.name ?? 'Unknown',
                        () {
                          // Ação para selecionar a bandeira do cartão
                          // checkoutController.selectCard(brand.name ?? '');
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          )
        : const SizedBox();
  }

  // Função para garantir o retorno de uma lista de CardBrandModel
  Future<List<CardBrandModel>> _getCardBrandList() async {
    List<dynamic> rawList = await Get.find<CardBrandController>().getAcceptedCardBrandListByStoreId(storeId);
    return rawList.map((item) => CardBrandModel.fromJson(item)).toList(); // Mapeamento correto de dynamic para CardBrandModel
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
