
class Outfit {
  final String id;
  final String name;
  final List<String> clothingIds;
  bool isFavorite;
  final DateTime createdAt;

  Outfit({
    String? id,
    required this.name,
    required this.clothingIds,
    this.isFavorite = false,
    DateTime? createdAt,
  })  : id = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();
}
