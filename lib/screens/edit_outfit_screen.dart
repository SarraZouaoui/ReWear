
import 'package:flutter/material.dart';
import '../data/fake_clothes.dart';
import '../models/outfit.dart';

class EditOutfitScreen extends StatefulWidget {
  final Outfit outfit;

  const EditOutfitScreen({
    super.key,
    required this.outfit,
  });

  @override
  State<EditOutfitScreen> createState() =>
      _EditOutfitScreenState();
}

class _EditOutfitScreenState extends State<EditOutfitScreen> {
  late TextEditingController nameController;

  late Set<String> selectedClothingIds;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.outfit.name,
    );

    selectedClothingIds = {
      ...widget.outfit.clothingIds,
    };
  }

  void saveChanges() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Donne un nom à ta tenue'),
        ),
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

    // Modifier le nom de la tenue
    widget.outfit.name = nameController.text.trim();

    // Modifier la liste des vêtements
    widget.outfit.clothingIds
      ..clear()
      ..addAll(selectedClothingIds);

    // Retourner à l'écran précédent
    Navigator.pop(context, true);
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
        title: const Text('Modifier la tenue'),
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
                Text(
                  '${selectedClothingIds.length} sélectionné(s)',
                ),
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
                      '${clothing.category} • '
                      '${clothing.color} • '
                      '${clothing.season}',
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
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF705C4B),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Enregistrer les modifications',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
