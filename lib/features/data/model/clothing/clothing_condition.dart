class ClothingCondition {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;
  String? condition;

  ClothingCondition(
      {this.id,
      this.active,
      this.arabicName,
      this.englishName,
      this.condition});

  ClothingCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['condition'] = this.condition;
    return data;
  }
}
