import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class NeedResponse {
  String? id;
  bool? active;
  String? title;
  String? description;
  String? needDate;
  String? needExpirationDate;
  String? category;
  String? status;
  String? communicationMethod;
  String? imageUrl;
  City? city;
  User? user;
  String? qrCode;
  int? reputation;
  int? age;
  String? bloodType;
  String? hospital;
  String? illness;
  String? whatsappLink;
  String? telegramLink;

  NeedResponse(
      {this.id,
      this.active,
      this.title,
      this.description,
      this.needDate,
      this.needExpirationDate,
      this.category,
      this.status,
      this.communicationMethod,
      this.imageUrl,
      this.city,
      this.user,
      this.qrCode,
      this.reputation,
      this.age,
      this.bloodType,
      this.hospital,
      this.illness});

  NeedResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    title = json['title'];
    description = json['description'];
    needDate = json['need_date'];
    needExpirationDate = json['need_expiration_date'];
    category = json['category'];
    status = json['status'];
    communicationMethod = json['communication_method'];
    imageUrl = json['image_url'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    qrCode = json['qr_code'];
    reputation = json['reputation'];
    age = json['age'];
    bloodType = json['blood_type'];
    hospital = json['hospital'];
    illness = json['illness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['title'] = this.title;
    data['description'] = this.description;
    data['need_date'] = this.needDate;
    data['need_expiration_date'] = this.needExpirationDate;
    data['category'] = this.category;
    data['status'] = this.status;
    data['communication_method'] = this.communicationMethod;
    data['image_url'] = this.imageUrl;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['qr_code'] = this.qrCode;
    data['reputation'] = this.reputation;
    data['age'] = this.age;
    data['blood_type'] = this.bloodType;
    data['hospital'] = this.hospital;
    data['illness'] = this.illness;
    return data;
  }
}
