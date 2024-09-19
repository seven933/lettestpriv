import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardInfos extends StatelessWidget {
  final String nickname;
  final String cardNumber;
  final String type;

  const CardInfos({
    Key? key,
    required this.nickname,
    required this.cardNumber,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    String maskedCardNumber = 'XXXX XXXX XXXX $lastFourDigits';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // Lógica para editar
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Lógica para excluir
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'account_card_nickname'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Icon(
                  Icons.credit_card,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              nickname,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'account_card_type'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Icon(
                  Icons.card_membership,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              type,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'account_card_number'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Icon(
                  Icons.confirmation_number,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              maskedCardNumber,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
