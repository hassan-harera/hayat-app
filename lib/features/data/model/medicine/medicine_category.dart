class MedicineCategory {
  int? id;
  bool? active;
  String? arabicName;

  MedicineCategory({this.id, this.active, this.arabicName});

  MedicineCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    return data;
  }
}
