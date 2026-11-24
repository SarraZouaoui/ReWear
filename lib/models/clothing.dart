
class Clothing {
  final String id;
  final String name;
  final String category;
  final String color;
  final String season;
  final String image;

  static int _idCounter = 0;

  static String _generateId() {
    return '${DateTime.now().microsecondsSinceEpoch}_${_idCounter++}';
  }

  Clothing({
    String? id,
    required this.name,
    required this.category,
    required this.color,
    required this.season,
    required this.image,
  }) : id = id ?? _generateId();
}
