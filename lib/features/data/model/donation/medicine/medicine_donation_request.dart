class MedicineDonationRequest {
  String? title;
  String? description;
  String? donationDate;
  String? donationExpirationDate;
  String? category;
  String? status;
  String? communicationMethod;
  int? cityId;
  String? imageUrl;
  String? telegramLink;
  String? whatsappLink;
  String? qrCode;
  int? reputation;
  int? quantity;
  MedicineUnit? medicineUnit;
  String? medicineExpirationDate;
  int? medicineUnitId;
  int? medicineId;
  int? unitId;

  MedicineDonationRequest(
      {this.title,
      this.description,
      this.donationDate,
      this.donationExpirationDate,
      this.category,
      this.status,
      this.communicationMethod,
      this.cityId,
      this.imageUrl,
      this.telegramLink,
      this.whatsappLink,
      this.qrCode,
      this.reputation,
      this.quantity,
      this.medicineUnit,
      this.medicineExpirationDate,
      this.medicineUnitId,
      this.medicineId,
      this.unitId});

  MedicineDonationRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    donationDate = json['donation_date'];
    donationExpirationDate = json['donation_expiration_date'];
    category = json['category'];
    status = json['status'];
    communicationMethod = json['communication_method'];
    cityId = json['city_id'];
    imageUrl = json['image_url'];
    telegramLink = json['telegram_link'];
    whatsappLink = json['whatsapp_link'];
    qrCode = json['qr_code'];
    reputation = json['reputation'];
    quantity = json['quantity'];
    medicineUnit = json['medicine_unit'] != null
        ? new MedicineUnit.fromJson(json['medicine_unit'])
        : null;
    medicineExpirationDate = json['medicine_expiration_date'];
    medicineUnitId = json['medicine_unit_id'];
    medicineId = json['medicine_id'];
    unitId = json['unit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['donation_date'] = this.donationDate;
    data['donation_expiration_date'] = this.donationExpirationDate;
    data['category'] = this.category;
    data['status'] = this.status;
    data['communication_method'] = this.communicationMethod;
    data['city_id'] = this.cityId;
    data['image_url'] = this.imageUrl;
    data['telegram_link'] = this.telegramLink;
    data['whatsapp_link'] = this.whatsappLink;
    data['qr_code'] = this.qrCode;
    data['reputation'] = this.reputation;
    data['quantity'] = this.quantity;
    if (this.medicineUnit != null) {
      data['medicine_unit'] = this.medicineUnit!.toJson();
    }
    data['medicine_expiration_date'] = this.medicineExpirationDate;
    data['medicine_unit_id'] = this.medicineUnitId;
    data['medicine_id'] = this.medicineId;
    data['unit_id'] = this.unitId;
    return data;
  }
}

class MedicineUnit {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;

  MedicineUnit({this.id, this.active, this.arabicName, this.englishName});

  MedicineUnit.fromJson(Map<String, dynamic> json) {
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
