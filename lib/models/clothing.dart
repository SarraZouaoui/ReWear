
class Clothing {
  final String id;
  final String name;
  final String category;
  final String color;
  final String season;
  final String image;

  Clothing({
    String? id,
    required this.name,
    required this.category,
    required this.color,
    required this.season,
    required this.image,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();
}
