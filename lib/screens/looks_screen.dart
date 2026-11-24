
import 'package:flutter/material.dart';
import '../data/fake_outfits.dart';
import 'create_outfit_screen.dart';
import 'outfit_details_screen.dart';

class LooksScreen extends StatefulWidget {
  const LooksScreen({super.key});

  @override
  State<LooksScreen> createState() => _LooksScreenState();
}

class _LooksScreenState extends State<LooksScreen> {

  Future<void> openCreateOutfit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateOutfitScreen(),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  Future<void> openOutfitDetails(int index) async {
    final outfit = fakeOutfits[index];

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutfitDetailsScreen(
          outfit: outfit,
        ),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),

      appBar: AppBar(
        title: const Text('Mes Looks'),
        backgroundColor: const Color(0xFFF8F6F1),
        elevation: 0,
      ),

      body: fakeOutfits.isEmpty
          ? const Center(
              child: Text(
                'Aucune tenue créée pour le moment',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: fakeOutfits.length,
              itemBuilder: (context, index) {
                final outfit = fakeOutfits[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),

                  child: ListTile(
                    onTap: () {
                      openOutfitDetails(index);
                    },

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8DED3),
                      child: Icon(
                        Icons.checkroom,
                        color: Color(0xFF705C4B),
                      ),
                    ),

                    title: Text(
                      outfit.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${outfit.clothingIds.length} vêtement(s)',
                    ),

                    trailing: Icon(
                      outfit.isFavorite
                          ? Icons.favorite
                          : Icons.arrow_forward_ios,
                      color: outfit.isFavorite
                          ? Colors.red
                          : Colors.grey,
                      size: 20,
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: openCreateOutfit,
        backgroundColor: const Color(0xFF705C4B),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
