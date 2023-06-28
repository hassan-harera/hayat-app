

class MedicineUnit {
  final int id;
  final bool active;
  final String arabicName;
  final String englishName;

  MedicineUnit({
    required this.id,
    required this.active,
    required this.arabicName,
    required this.englishName,
  });

  factory MedicineUnit.fromJson(Map<String, dynamic> json) {
    return MedicineUnit(
      id: json['id'] as int,
      active: json['active'] as bool,
      arabicName: json['arabic_name'] as String,
      englishName: json['english_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'arabic_name': arabicName,
      'english_name': englishName,
    };
  }
}
