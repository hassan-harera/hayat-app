class FoodCategory {
  int? id;
  bool? active;
  String? description;
  String? arabicName;
  String? englishName;

  FoodCategory(
      {this.id,
      this.active,
      this.description,
      this.arabicName,
      this.englishName});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    description = json['description'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['description'] = this.description;
    data['arabic_name'] = this.arabicName;
    data['english_name'] = this.englishName;
    return data;
  }
}
