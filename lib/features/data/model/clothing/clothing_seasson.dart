class ClothingSeason {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;
  String? season;

  ClothingSeason(
      {this.id, this.active, this.arabicName, this.englishName, this.season});

  ClothingSeason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['season'] = this.season;
    return data;
  }
}
