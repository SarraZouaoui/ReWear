
import 'package:flutter/material.dart';
import '../models/clothing.dart';
import '../data/fake_clothes.dart';
import 'add_clothing_screen.dart';
import 'clothing_detail.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  String selectedCategory = 'Tout';

  final Set<String> favorites = {};

  final List<String> categories = [
    'Tout',
    'Haut',
    'Manteau',
    'Veste',
    'Robe',
  ];

  // Filtrer les vêtements par catégorie
  List<Clothing> get filteredClothes {
    if (selectedCategory == 'Tout') {
      return fakeClothes;
    }

    return fakeClothes
        .where((clothing) => clothing.category == selectedCategory)
        .toList();
  }

  // Ouvrir le formulaire et récupérer le nouveau vêtement
  Future<void> openAddClothing() async {
    final newClothing = await Navigator.push<Clothing>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddClothingScreen(),
      ),
    );

    if (newClothing != null) {
      setState(() {
        fakeClothes.add(newClothing);
      });
    }
  }

  // Ouvrir la page de détail du vêtement sélectionné
  void openClothingDetail(Clothing clothing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothingDetailScreen(
          clothing: clothing,
        ),
      ),
    );
  }

  // Ajouter ou retirer un vêtement des favoris
  void toggleFavorite(Clothing clothing) {
    setState(() {
      if (favorites.contains(clothing.name)) {
        favorites.remove(clothing.name);
      } else {
        favorites.add(clothing.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8DED0),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.checkroom_rounded,
                          color: Color(0xFF665343),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 9),
                      const Text(
                        'ReWear',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.8,
                          color: Color(0xFF252525),
                        ),
                      ),
                    ],
                  ),

                  // Search and Add buttons
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                            size: 21,
                            color: Color(0xFF252525),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF665343),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: openAddClothing,
                          icon: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 19),

              // Page title
              const Text(
                'Discover your style',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: Color(0xFF252525),
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                'Find pieces you will love.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),

              const SizedBox(height: 16),

              // Categories
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected =
                        selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF665343)
                              : Colors.white,
                          borderRadius:
                              BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF665343)
                                : const Color(0xFFEAE5DE),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF665343),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 19),

              // Products title
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New arrivals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF252525),
                    ),
                  ),
                  Text(
                    '${filteredClothes.length} items',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Clothing grid
              Expanded(
                child: filteredClothes.isEmpty
                    ? const Center(
                        child: Text(
                          'Aucun vêtement dans cette catégorie.',
                          style: TextStyle(
                            color: Color(0xFF888888),
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding:
                            const EdgeInsets.only(bottom: 20),
                        itemCount: filteredClothes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (context, index) {
                          final clothing =
                              filteredClothes[index];

                          final isFavorite =
                              favorites.contains(clothing.name);

                          return _buildClothingCard(
                            clothing,
                            isFavorite,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Clothing card
  Widget _buildClothingCard(
    Clothing clothing,
    bool isFavorite,
  ) {
    return GestureDetector(
      onTap: () {
        openClothingDetail(clothing);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and favorite button
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      clothing.image,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF0EDE7),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 35,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        toggleFavorite(clothing);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Colors.black,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Clothing information
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    clothing.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF252525),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    clothing.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    clothing.color,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
