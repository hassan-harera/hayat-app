class FoodUnit {
  final int id;
  final bool active;
  final String arabicName;

  // final String description;
  final String englishName;

  FoodUnit({
    required this.id,
    required this.active,
    required this.arabicName,
    required this.englishName,
    // required this.description,
  });

  factory FoodUnit.fromJson(Map<String, dynamic> json) {
    return FoodUnit(
      id: json['id'] as int,
      active: json['active'] as bool,
      arabicName: json['arabic_name'] as String,
      englishName: json['english_name'] as String,
      //description: json['description']as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'arabic_name': arabicName,
      'english_name': englishName,
      // 'description':description
    };
  }
}
// /api/v1/medicine/units
// /api/v1/food/units
