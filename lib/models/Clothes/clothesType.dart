class ClothesType {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;
  String? type;

  ClothesType(
      {this.id, this.active, this.arabicName, this.englishName, this.type});

  ClothesType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['type'] = this.type;
    return data;
  }
}