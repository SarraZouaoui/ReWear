
import 'package:flutter/material.dart';
import '../models/clothing.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() => _AddClothingScreenState();
}

class _AddClothingScreenState extends State<AddClothingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  String selectedCategory = 'Haut';
  String selectedSeason = 'Été';
  String? selectedImage;

  final List<String> categories = [
    'Haut',
    'Bas',
    'Chaussures',
    'Accessoire',
    'Manteau',
    'Veste',
    'Robe',
  ];

  final List<String> seasons = [
    'Printemps',
    'Été',
    'Automne',
    'Hiver',
  ];

  final List<String> images = [
    'assets/images/pull_maron.png',
    'assets/images/pull_blanc.png',
    'assets/images/image.png',
    'assets/images/veste1.png',
    'assets/images/veste2.png',
    'assets/images/robe_rose.png',
  ];

  void addClothing() {
    if (nameController.text.trim().isEmpty ||
        colorController.text.trim().isEmpty ||
        selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs et choisir une photo.'),
        ),
      );
      return;
    }

    Clothing newClothing = Clothing(
      name: nameController.text.trim(),
      category: selectedCategory,
      color: colorController.text.trim(),
      season: selectedSeason,
      image: selectedImage!,
    );

    Navigator.pop(context, newClothing);
  }

  @override
  void dispose() {
    nameController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un vêtement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nom du vêtement',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ex : Pull marron',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Catégorie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Couleur',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(
                hintText: 'Ex : Marron',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Saison',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedSeason,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: seasons.map((season) {
                return DropdownMenuItem(
                  value: season,
                  child: Text(season),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSeason = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Photo du vêtement',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: images.map((image) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = image;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImage == image
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        width: selectedImage == image ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addClothing,
                child: const Text('Ajouter le vêtement'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
