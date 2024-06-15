import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/features/card/controllers/card_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/features/card/widgets/card_info.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';

class AccountCardListScreen extends StatefulWidget {
  const AccountCardListScreen({super.key});

  @override
  State<AccountCardListScreen> createState() => _AccountCardListScreenState();
}

class _AccountCardListScreenState extends State<AccountCardListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(builder: (cardController) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'my_account_cards'.tr,
          backButton: true,
        ),
        body: Container(
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cardController.accountCardList != null &&
                      cardController.accountCardList!.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: cardController.accountCardList!.length,
                        itemBuilder: (context, index) {
                          final card = cardController.accountCardList![index];
                          return CardInfos(
                            cardNumber: card.cardNumber,
                            nickname: card.nickname,
                            type: card.type,
                          );
                        },
                      ),
                    )
                  : Text('Você ainda não adicionou nenhum cartão'),
              const SizedBox(
                height: 8.0,
              ),
              CustomButton(
                isLoading: false,
                buttonText: 'add_new_account_card'.tr,
                onPressed: () {
                  Get.toNamed(RouteHelper.getAddCardAccountScreen());
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
