class Ayah {
  final int number;
  final String arabic;
  final String translation;
  final String transliteration;

  Ayah({
    required this.number,
    required this.arabic,
    required this.translation,
    this.transliteration = '',
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json['number'],
        arabic: json['arabic'],
        translation: json['translation'],
        transliteration: json['transliteration'] ?? '',
      );
}
