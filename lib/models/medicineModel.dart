
class MedicineModel {
  final int id;
  final bool active;
  final String arabicName;
  final String englishName;
  final String category;
  final String unit;

  MedicineModel({
    required this.unit,
    required this.id,
    required this.category,
    required this.active,
    required this.arabicName,
    required this.englishName,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      unit:json['unit']as String,
      category: json['category'] as String ,
      id: json['id'] as int ,
      active: json['active'] as bool,
      arabicName: json['arabic_name']as String ,
      englishName: json['english_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category':category,
      'id': id,
      'unit':unit,
      'active': active,
      'arabic_name': arabicName,
      'english_name': englishName,
    };
  }
}
