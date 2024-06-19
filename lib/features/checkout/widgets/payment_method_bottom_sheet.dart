import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/payment/widgets/offline_payment_button.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_button_new.dart';
import 'package:sixam_mart/features/card/controllers/card_controller.dart';
import 'package:sixam_mart/features/checkout/widgets/do_you_need_change.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  final bool isCashOnDeliveryActive;
  //final bool isPaymentOnDeliveryActive = false;
  //final bool isPixOnliveryActive;
  final bool isDigitalPaymentActive;
  final bool isOfflinePaymentActive;
  final bool isWalletActive;
  final int? storeId;
  final double totalPrice;
  //final bool needchange;

  const PaymentMethodBottomSheet(
      {super.key,
      required this.isCashOnDeliveryActive,
      required this.isDigitalPaymentActive,
      required this.isWalletActive,
      required this.storeId,
      required this.totalPrice,
      required this.isOfflinePaymentActive});

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {

  bool canSelectWallet = true;
  bool notHideCod = true;
  bool notHideWallet = true;
  bool notHideDigital = true;
  bool isDigitalPaymentSelected = false;
  List<String> toggleLabels = ['payment_on_delivery'.tr, 'digital_payment'.tr];
  int selectedToggleIndex = 0;
  Color selectedColor = Color(0xFF039D55);
  Color unselectedColor = Color(0xFFBABFC4);
  List<bool> isSelected = [true, false];
  double cashToChange = 0.0;
  double cashOnDelivery = 0.0;

  final JustTheController tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();

    if (!AuthHelper.isGuestLoggedIn()) {
      double walletBalance =
          Get.find<ProfileController>().userInfoModel!.walletBalance!;
      if (walletBalance < widget.totalPrice) {
        canSelectWallet = false;
      }
      if (Get.find<CheckoutController>().isPartialPay) {
        notHideWallet = false;
        if (Get.find<SplashController>().configModel!.partialPaymentMethod! ==
            'cod') {
          notHideCod = true;
          notHideDigital = false;
        } else if (Get.find<SplashController>()
                .configModel!
                .partialPaymentMethod! ==
            'digital_payment') {
          notHideCod = false;
          notHideDigital = true;
        } else if (Get.find<SplashController>()
                .configModel!
                .partialPaymentMethod! ==
            'both') {
          notHideCod = true;
          notHideDigital = true;
        }
      }
    }
  }
  
  // Exibe o PopUp com o valor do dinheiro a ser pago na entrega
  void _showCashOnDeliveryPopup(CheckoutController checkoutController) {


    TextEditingController amountController = TextEditingController();

     Get.dialog(
      AlertDialog(
        title: Text('cash_on_delivery'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('enter_the_amount_to_pay_on_delivery'.tr),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: InputDecoration(labelText: 'amount'.tr),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Confirma o valor
              String amountText = amountController.text;
              if (amountText.isNotEmpty) {
                try {
                  // Remover espaços em branco
                  amountText = amountText.trim();
                  
                  // Substituir vírgulas por pontos
                  String rawAmount = amountText.replaceAll(',', '.');

                  // Verificar se a entrada é válida antes de converter
                  if (RegExp(r'^[0-9]*\.?[0-9]+$').hasMatch(rawAmount)) {
                    double cashOnDelivery = double.parse(rawAmount);

                    checkoutController.setAmountCashOnDelivery(cashOnDelivery);
                  } else {
                    print('Valor inválido');
                  }
                } catch (e) {
                  print('Erro ao converter o valor para double: $e');
                }
              }
              Get.back();
            },
            child: CustomButton(
              isLoading: false,
              buttonText: 'confirm'.tr,
              onPressed: () {
                String amountText = amountController.text;
                if (amountText.isNotEmpty) {
                  try {
                    // Remover espaços em branco
                    amountText = amountText.trim();
                  
                    // Substituir vírgulas por pontos
                    String rawAmount = amountText.replaceAll(',', '.');

                    // Verificar se a entrada é válida antes de converter
                    if (RegExp(r'^[0-9]*\.?[0-9]+$').hasMatch(rawAmount)) {
                      double cashOnDelivery = double.parse(rawAmount);

                      checkoutController.setAmountCashOnDelivery(cashOnDelivery);
                    } else {
                      print('Valor inválido');
                    }
                  } catch (e) {
                    print('Erro ao converter o valor para double: $e');
                  }
                }
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }



  // Exibe o bottomsheet com as bandeiras de cartão na entrega
  void _showCardOnDeliverySelectionDialog({required bool isCreditCard}) {

    final StoreController storeController = Get.find<StoreController>();
    storeController.getCardBrandList(widget.storeId);

      Get.bottomSheet(

        GetBuilder<StoreController>(
          builder: (controller) {
            if (controller.cardBrandList == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<Widget> brandButtons = controller.cardBrandList!.map((brand) {
                return _buildCardBrandButton(brand.image);
              }).toList();

              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isCreditCard ? 'select_credit_card_brand'.tr : 'select_debit_card_brand'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      children: brandButtons,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
  }

  Widget _buildCardBrandButton(String imageUrl) {
  return IconButton(
    icon: Image.network(imageUrl),
    onPressed: () {
      // Implementar ação ao clicar no botão
      Get.back();
    },
  );
}

  // Seleciona a bandeira do cartão na entrega
  /*Widget _buildCardBrandButton(String image) {
    return IconButton(
      icon: Image.asset(image),
      onPressed: () {
        // Lógica para selecionar a bandeira do cartão
        Get.back();
      },
    );
  }*/


  // Exibe um bottomsheet com a lista de cartões cadastrados
  void _showCardSelectionDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<CardController>(
          builder: (cardController) {
            if (cardController.accountCardList != null &&
                cardController.accountCardList!.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: cardController.accountCardList!.map((card) {
                  return InkWell(
                    onTap: () {
                      // Lógica para selecionar o cartão e atualizar a interface do usuário
                      // checkoutController.selectCard(card);
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), 
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.nickname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                // Imagem da bandeira do cartão
                                Image.asset(
                                  _getCardBrandImage(card.brand), // Método para obter a imagem da bandeira
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(width: 8.0),
                                // Texto do número do cartão
                                Text(
                                  _maskCardNumber(card.cardNumber),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Validade: ${card.expirationDate}',
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {

              return Column(
                children: [
                  Text(
                    'no_cards_available'.tr,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela de cadastro de cartões
                      Get.toNamed(RouteHelper.getAddCardAccountScreen());
                    },
                    child: Text('register_card'.tr),
                  ),
                ],
              );

            }
          },
        ),
      ),
    );
  }

  String _maskCardNumber(String cardNumber) {
    int length = cardNumber.length;
    return 'X' * (length - 4) + cardNumber.substring(length - 4);
  }

  // Pega a imagem da bandeira do cartão
  String _getCardBrandImage(String brand) {
    switch (brand) {
      case 'mastercard':
        return Images.mastercard;
      case 'visa':
        return Images.visa;
      default:
        return Images.landingCheckout; 
    }
  }

  // Lida com seleção do dinheiro na entrega como método de pagamento.
  void _handleCashOnDeliverySelection(CheckoutController checkoutController) async {

    checkoutController.setPaymentMethod(0);

    _showCashOnDeliveryPopup(checkoutController);

  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();

    return SizedBox(
      width: 550,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(Dimensions.radiusLarge),
            bottom: Radius.circular(0,),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
          vertical: Dimensions.paddingSizeLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 4,
                      width: 35,
                      margin: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // Use GestureDetector e Container para criar botões personalizados
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: toggleLabels.asMap().entries.map((entry) {
                int index = entry.key;
                String label = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedToggleIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: selectedToggleIndex == index
                          ? Theme.of(context).primaryColor // Cor de fundo quando selecionado
                          : unselectedColor, // Cor de fundo quando não selecionado
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: selectedToggleIndex == index
                            ? Colors.white // Cor do texto quando selecionado
                            : Colors.black, // Cor do texto quando não selecionado
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Flexible(
              child: SingleChildScrollView(
                child: GetBuilder<CheckoutController>(
                  builder: (checkoutController) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'payment_method'.tr,
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        
                        // Mostrar botões de pagamento com base no tipo selecionado
                        selectedToggleIndex == 1
                            ? Column(
                                children: [
                                  // Botões de pagamento digitais
                                  Flexible(
                                    child: widget.storeId == null &&
                                            widget.isWalletActive &&
                                            notHideWallet &&
                                            isLoggedIn
                                        ? PaymentButtonNew(
                                            icon: Images.partialWallet,
                                            title: 'wallet'.tr,
                                            isSelected: checkoutController
                                                    .paymentMethodIndex ==
                                                1,
                                            onTap: () {
                                              if (canSelectWallet) {
                                                checkoutController
                                                    .setPaymentMethod(1);
                                              } else if (checkoutController
                                                  .isPartialPay) {
                                                showCustomSnackBar(
                                                  'you_can_not_user_wallet_in_partial_payment'
                                                      .tr,
                                                );
                                                Get.back();
                                              } else {
                                                showCustomSnackBar(
                                                  'your_wallet_have_not_sufficient_balance'
                                                      .tr,
                                                );
                                                Get.back();
                                              }
                                            },
                                          )
                                        : const SizedBox(),
                                  ),
                                  Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.pix,
                                      title: 'pix'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          5,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(5);
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.cards,
                                      title: 'credit_card'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          6,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(6);
                                        _showCardSelectionDialog();
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.cards,
                                      title: 'debit_card'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          7,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(7);
                                        _showCardSelectionDialog();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  // Botões de pagamento físicos
                                  Flexible(
                                    child: widget.isCashOnDeliveryActive &&
                                            notHideCod
                                        ? PaymentButtonNew(
                                            icon: Images.codIcon,
                                            title: 'cash_on_delivery'.tr,
                                            isSelected: checkoutController
                                                    .paymentMethodIndex ==
                                                0,
                                            onTap: () => _handleCashOnDeliverySelection(checkoutController),
                                          )
                                        : const SizedBox(),
                                  ),
                                  // Pix na entrega
                                  /*Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.pix,
                                      title: 'pix_on_delivery'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          2,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(2);
                                      },
                                    ),
                                  ),*/
                                  Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.cards,
                                      title: 'credit_card_on_delivery'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          3,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(3);
                                        _showCardOnDeliverySelectionDialog(isCreditCard: true);
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: PaymentButtonNew(
                                      icon: Images.cards,
                                      title: 'debit_card_on_delivery'.tr,
                                      isSelected: checkoutController
                                              .paymentMethodIndex ==
                                          4,
                                      onTap: () {
                                        checkoutController.setPaymentMethod(4);
                                        _showCardOnDeliverySelectionDialog(isCreditCard: false);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    );
                  },
                ),
              ),
            ),
            SafeArea(
              child: CustomButton(
                buttonText: 'confirm'.tr,
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class NumberInputFormatter extends TextInputFormatter {

  final NumberFormat _formatter = NumberFormat("#,##0.00", "pt_BR");

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue,) {
    
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value;
    try {
      value = double.parse(newValue.text.replaceAll('.', '').replaceAll(',', '.'));
    } catch (e) {
      return oldValue;
    }

    final newText = _formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

}