import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/card/domain/models/card_model.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/features/card/controllers/card_controller.dart';
import 'package:flutter/services.dart';
import 'package:sixam_mart/util/images.dart';

enum CardBrand {visa, mastercard, elo, hipercard, americanexpress, alelo, invalid}

class AddCardAccountScreen extends StatefulWidget {
  @override
  _AddCardAccountScreenState createState() => _AddCardAccountScreenState();
}

class _AddCardAccountScreenState extends State<AddCardAccountScreen> {
  
  TextEditingController nicknameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cpfControlller = TextEditingController();


  int type = 0;
  CardBrand cardBrand = CardBrand.invalid;

  // Detecta o tipo do cartão pelo primeiro digito
  CardBrand _detectCardType(String cardNumber){

    String cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.startsWith('4')) {
      return CardBrand.visa;
    } else if (cleanNumber.startsWith('5')) {
      return CardBrand.mastercard;
    } else if (cleanNumber.startsWith('63') || 
               cleanNumber.startsWith('60')) {
      return CardBrand.hipercard;
    } else if (cleanNumber.startsWith('34') || 
               cleanNumber.startsWith('37')) {
      return CardBrand.americanexpress;
    } else {
      return CardBrand.invalid;
    }

  }

  // Detecta a bandeira do cartão pelo primeiro digito
  String _detectCardBrand(String cardNumber){

    String cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.startsWith('4')) {
      return 'visa';
    } else if (cleanNumber.startsWith('5')) {
      return 'mastercard';
    } else if (cleanNumber.startsWith('63') || 
               cleanNumber.startsWith('60')) {
      return 'hipercard';
    } else if (cleanNumber.startsWith('34') || 
               cleanNumber.startsWith('37')) {
      return 'americanexpress';
    } else {
      return 'invalid';
    }

  }

  String _getImagePath(CardBrand cardBrand) {

    switch (cardBrand) {
      case CardBrand.visa:
        return Images.visa;
      case CardBrand.mastercard:
        return Images.mastercard;
      default:
        return Images.landingCheckout;
    }

  }

  void _clearFields() {
    nicknameController.clear();
    cardNumberController.clear();
    expirationDateController.clear();
    cvvController.clear();
    typeController.clear();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('successfully_saved_card'.tr),
          content: Text('the_card_was_successfully_saved'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'.tr),
            ),
          ],
        );
      },
    );
  }

  // Salva os dados do cartão em cache
  void _handleSave() {
    final newCard = CardModel(
      nickname: nicknameController.text,
      cardHolderName: cardHolderNameController.text,
      cpf: cpfControlller.text,
      cardNumber: cardNumberController.text,
      expirationDate: expirationDateController.text,
      cvv: int.parse(cvvController.text),
      type: type == 0 ? 'credit'.tr : 'debit'.tr,
      brand: _detectCardBrand(cardNumberController.text),
    );

    Get.find<CardController>().addCard(newCard);

    _clearFields();
    _showConfirmationDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'account_card_registration'.tr),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: GetBuilder<CardController>(builder: (cardController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ToggleButtons(
                  borderRadius: BorderRadius.circular(20), 
                  borderWidth: 2,
                  children: [
                    Text('credit'.tr),
                    Text('debit'.tr),
                  ],
                  isSelected: [
                    cardController.isCredit ?? false,
                    !cardController.isCredit ?? true
                  ],
                  onPressed: (index){
                    cardController.setType(index == 0 ? 'credit'.tr : 'debit'.tr);
                    type = index;
                  }
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: nicknameController,
                  decoration:
                      InputDecoration(labelText: 'account_card_nickname'.tr),
                ),
                SizedBox(height: 12.0),

                TextField(
                  controller: cardHolderNameController,
                  decoration:
                      InputDecoration(labelText: 'card_holder'.tr),
                ),
                SizedBox(height: 12.0),

                TextField(
                  controller: cpfControlller,
                  decoration:
                      InputDecoration(labelText: 'card_holder_cpf'.tr),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [                    
                    Expanded(
                      child: TextField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'account_card_number'.tr,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            cardBrand = _detectCardType(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Image.asset(
                      _getImagePath(cardBrand),
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: expirationDateController,
                  decoration: InputDecoration(labelText: 'expiration_date'.tr),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5), 
                    ExpirationDateFormatter(), 
                  ],
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: cvvController,
                  decoration: InputDecoration(labelText: 'cvv'.tr),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3), 
                  ],
                ),
                SizedBox(height: 20.0),
                CustomButton(
                  isLoading: false,
                  buttonText: 'save'.tr,
                  onPressed: _handleSave,
                ),
              ],
            );
          }),
        ));
  }
}

class ExpirationDateFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    
    var newText = newValue.text;
    var buffer = new StringBuffer();

    if (newText.length <= 2) {
      buffer.write(newText);
    } else if (newText.length > 2 && newText.length <= 4) {
      buffer.write(newText.substring(0, 2) + '/' + newText.substring(2));
    } else {
      buffer.write(oldValue.text); 
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}


class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    var buffer = new StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newText.length) {
        buffer.write(' ');
      }
    }
    return newValue.copyWith(
      text: buffer.toString(),
      selection: new TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}