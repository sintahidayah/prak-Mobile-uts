class Dua {
  final String id;
  final String title;
  final String category;
  final String arabic;
  final String transliteration;
  final String translation;
  bool isFavorite;

  Dua({
    required this.id,
    required this.title,
    required this.category,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.isFavorite = false,
  });

  factory Dua.fromJson(Map<String, dynamic> json) => Dua(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        arabic: json['arabic'],
        transliteration: json['transliteration'],
        translation: json['translation'],
        isFavorite: json['isFavorite'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'arabic': arabic,
        'transliteration': transliteration,
        'translation': translation,
        'isFavorite': isFavorite,
      };
}
