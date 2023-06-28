class City {
  final int id;
  final String arabicName;
  final String englishName;

  City({
    required this.id,
    required this.arabicName,
    required this.englishName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      arabicName: json['arabicName'] as String,
      englishName: json['englishName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabicName': arabicName,
      'englishName': englishName,
    };
  }
}
