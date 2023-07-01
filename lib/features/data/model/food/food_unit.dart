class FoodUnit {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;

  FoodUnit({this.id, this.active, this.arabicName, this.englishName});

  FoodUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabic_name'] = this.arabicName;
    data['english_name'] = this.englishName;
    return data;
  }
}
