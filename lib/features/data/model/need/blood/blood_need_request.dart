class BloodNeedRequest {
  String? title;
  String? description;
  int? cityId;
  String? communicationMethod;
  String? bloodType;
  int? age;
  String? hospital;
  String? illness;

  BloodNeedRequest(
      {this.title,
        this.description,
        this.cityId,
        this.communicationMethod,
        this.bloodType,
        this.age,
        this.hospital,
        this.illness});

  BloodNeedRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    cityId = json['city_id'];
    communicationMethod = json['communication_method'];
    bloodType = json['blood_type'];
    age = json['age'];
    hospital = json['hospital'];
    illness = json['illness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['city_id'] = this.cityId;
    data['communication_method'] = this.communicationMethod;
    data['blood_type'] = this.bloodType;
    data['age'] = this.age;
    data['hospital'] = this.hospital;
    data['illness'] = this.illness;
    return data;
  }
}
