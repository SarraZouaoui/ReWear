
import 'package:flutter/material.dart';
import '../data/fake_clothes.dart';
import '../data/fake_outfits.dart';
import '../models/outfit.dart';

class CreateOutfitScreen extends StatefulWidget {
  const CreateOutfitScreen({super.key});

  @override
  State<CreateOutfitScreen> createState() => _CreateOutfitScreenState();
}

class _CreateOutfitScreenState extends State<CreateOutfitScreen> {
  final TextEditingController nameController = TextEditingController();

  final Set<String> selectedClothingIds = {};
  /////
  @override
void initState() {
  super.initState();

  for (final clothing in fakeClothes) {
    debugPrint('${clothing.name} -> ${clothing.id}');
  }
}


  void saveOutfit() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donne un nom à ta tenue')),
      );
      return;
    }

    if (selectedClothingIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sélectionne au moins un vêtement'),
        ),
      );
      return;
    }

    final newOutfit = Outfit(
      name: nameController.text.trim(),
      clothingIds: selectedClothingIds.toList(),
    );

    fakeOutfits.add(newOutfit);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      appBar: AppBar(
        title: const Text('Créer une tenue'),
        backgroundColor: const Color(0xFFF8F6F1),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nom de la tenue',
                hintText: 'Exemple : Look automne',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choisir les vêtements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${selectedClothingIds.length} sélectionné(s)'),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: fakeClothes.length,
              itemBuilder: (context, index) {
                final clothing = fakeClothes[index];

                final isSelected =
                    selectedClothingIds.contains(clothing.id);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    activeColor: const Color(0xFF705C4B),
                    title: Text(clothing.name),
                    subtitle: Text(
                      '${clothing.category} • ${clothing.color} • ${clothing.season}',
                    ),
                    secondary: Image.asset(
                      clothing.image,
                      width: 55,
                      height: 65,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.checkroom,
                          size: 40,
                        );
                      },
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedClothingIds.add(clothing.id);
                        } else {
                          selectedClothingIds.remove(clothing.id);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveOutfit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF705C4B),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Enregistrer la tenue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
