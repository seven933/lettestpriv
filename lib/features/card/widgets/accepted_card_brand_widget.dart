import 'package:flutter/material.dart';
import 'package:sixam_mart/features/card/domain/models/card_brand_model.dart';

class AcceptedCardBrand extends StatelessWidget {
  final List<CardBrandModel?> cardBrands;

  const AcceptedCardBrand({Key? key, required this.cardBrands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cartões Aceitos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCardBrandGrid(),
          ],
        ),
      ),
    );
  }

    Widget _buildCardBrandGrid() {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),  // Desabilita o scroll, pois estamos definindo a altura
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,  // Número de colunas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: cardBrands.length,
        itemBuilder: (context, index) {
          final cardBrand = cardBrands[index];

          // Verifica se a bandeira é nula
          if (cardBrand == null) return const SizedBox.shrink();

          // Trata valores nulos de imagem e nome
          final imageUrl = cardBrand.image ?? 'https://static.vecteezy.com/system/resources/thumbnails/012/042/301/small_2x/warning-sign-icon-transparent-background-free-png.png'; // Imagem padrão
          final name = cardBrand.name ?? 'Nome indisponível'; // Nome padrão

          return Column(
            children: [
              Expanded(
                child: Image.network(
                  imageUrl, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Ícone de erro
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
