import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine_unit.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class MedicineNeedResponse extends NeedResponse {
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
  double? quantity;
  MedicineUnit? medicineUnit;
  Medicine? medicine;

  MedicineNeedResponse(
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
      this.quantity,
      this.medicineUnit,
      this.medicine});

  MedicineNeedResponse.fromJson(Map<String, dynamic> json) {
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
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    qrCode = json['qr_code'];
    reputation = json['reputation'];
    quantity = json['quantity'];
    medicineUnit = json['medicine_unit'] != null
        ? MedicineUnit.fromJson(json['medicine_unit'])
        : null;
    medicine =
        json['medicine'] != null ? Medicine.fromJson(json['medicine']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['quantity'] = this.quantity;
    if (this.medicineUnit != null) {
      data['medicine_unit'] = this.medicineUnit!.toJson();
    }
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.toJson();
    }
    return data;
  }
}
