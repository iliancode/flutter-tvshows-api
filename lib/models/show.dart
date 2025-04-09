class Show {
  final int id;
  final String name;
  final String image;
  final String description;

  Show({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] ?? 0,
      name: json['name'],
      image: json['image_thumbnail_path'],
      description: json['description'] ?? 'Pas de description disponible',
    );
  }
}
