import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';


class AcceptedCardBrand extends StatelessWidget {
	
  final List<CardBrandModel?> cardBrands;

  const AcceptedCardBrand({Key? key, required this.cardBrands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cartões Aceitos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildCardBrandGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBrandGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: cardBrands.length,
      itemBuilder: (context, index) {
        final cardBrand = cardBrands[index];
        if (cardBrand == null) return SizedBox.shrink();

        return Column(
          children: [
            Expanded(
              child: Image.network(
                cardBrand.image, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error), 
              ),
            ),
            SizedBox(height: 4),
            Text(
              cardBrand.name,
              style: TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
