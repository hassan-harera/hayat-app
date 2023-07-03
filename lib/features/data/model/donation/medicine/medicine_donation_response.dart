import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/features/data/model/medicine_unit.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class MedicineDonationResponse extends DonationResponse {
  int? id;
  String? title;
  String? description;
  String? donationDate;
  String? donationExpirationDate;
  String? status;
  String? communicationMethod;
  City? city;
  User? user;
  String? imageUrl;
  String? telegramLink;
  String? whatsappLink;
  String? qrCode;
  int? reputation;
  double? quantity;
  MedicineUnit? medicineUnit;
  String? medicineExpirationDate;
  Medicine? medicine;

  MedicineDonationResponse(
      {this.id,
      this.title,
      this.description,
      this.donationDate,
      this.donationExpirationDate,
      super.category,
      this.status,
      this.communicationMethod,
      this.city,
      this.user,
      this.imageUrl,
      this.telegramLink,
      this.whatsappLink,
      this.qrCode,
      this.reputation,
      this.quantity,
      this.medicineUnit,
      this.medicineExpirationDate,
      this.medicine});

  MedicineDonationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    donationDate = json['donation_date'];
    donationExpirationDate = json['donation_expiration_date'];
    category = json['category'];
    status = json['status'];
    communicationMethod = json['communication_method'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    medicine = json['medicine'] != null
        ? new Medicine.fromJson(json['medicine'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['donation_date'] = this.donationDate;
    data['donation_expiration_date'] = this.donationExpirationDate;
    data['category'] = this.category;
    data['status'] = this.status;
    data['communication_method'] = this.communicationMethod;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.toJson();
    }
    return data;
  }
}
