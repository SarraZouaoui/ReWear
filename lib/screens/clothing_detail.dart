import 'package:flutter/material.dart';
import '../models/clothing.dart';

class ClothingDetailScreen extends StatelessWidget {
  final Clothing clothing;

  const ClothingDetailScreen({
    super.key,
    required this.clothing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du vêtement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                clothing.image,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              clothing.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text('Catégorie : ${clothing.category}'),
            const SizedBox(height: 12),

            Text('Couleur : ${clothing.color}'),
            const SizedBox(height: 12),

            Text('Saison : ${clothing.season}'),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Retour à ma garde-robe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

