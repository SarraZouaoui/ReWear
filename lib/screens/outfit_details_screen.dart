
import 'package:flutter/material.dart';
import '../data/fake_clothes.dart';
import '../data/fake_outfits.dart';
import '../models/outfit.dart';
import 'edit_outfit_screen.dart';

class OutfitDetailsScreen extends StatefulWidget {
  final Outfit outfit;

  const OutfitDetailsScreen({
    super.key,
    required this.outfit,
  });

  @override
  State<OutfitDetailsScreen> createState() =>
      _OutfitDetailsScreenState();
}

class _OutfitDetailsScreenState
    extends State<OutfitDetailsScreen> {

  void toggleFavorite() {
    setState(() {
      widget.outfit.isFavorite =
          !widget.outfit.isFavorite;
    });
  }

  Future<void> editOutfit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOutfitScreen(
          outfit: widget.outfit,
        ),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {});
    }
  }

  void deleteOutfit() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Supprimer la tenue'),
          content: const Text(
            'Voulez-vous vraiment supprimer cette tenue ?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                fakeOutfits.removeWhere(
                  (item) => item.id == widget.outfit.id,
                );

                Navigator.pop(dialogContext);
                Navigator.pop(context, true);
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedClothes = fakeClothes.where(
      (clothing) =>
          widget.outfit.clothingIds.contains(clothing.id),
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),

      appBar: AppBar(
        title: const Text('Détails de la tenue'),
        backgroundColor: const Color(0xFFF8F6F1),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              widget.outfit.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.outfit.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF705C4B),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${selectedClothes.length} vêtement(s) dans cette tenue',
            ),

            const SizedBox(height: 20),

            const Text(
              'Les vêtements de cette tenue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (selectedClothes.isEmpty)
              const Center(
                child: Text('Aucun vêtement trouvé'),
              )
            else
              ...selectedClothes.map((clothing) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: Image.asset(
                      clothing.image,
                      width: 65,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.checkroom,
                          size: 40,
                        );
                      },
                    ),

                    title: Text(
                      clothing.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${clothing.category} • '
                      '${clothing.color} • '
                      '${clothing.season}',
                    ),
                  ),
                );
              }),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: editOutfit,
                icon: const Icon(Icons.edit),
                label: const Text('Modifier la tenue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF705C4B),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: deleteOutfit,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Supprimer la tenue'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
