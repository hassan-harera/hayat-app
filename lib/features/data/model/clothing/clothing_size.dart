class ClothingSize {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;
  String? size;

  ClothingSize(
      {this.id, this.active, this.arabicName, this.englishName, this.size});

  ClothingSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['size'] = this.size;
    return data;
  }
}
