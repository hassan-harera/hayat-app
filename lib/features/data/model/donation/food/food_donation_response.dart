import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class FoodDonationResponse {
  int? id;
  bool? active;
  String? title;
  String? description;
  String? donationDate;
  String? donationExpirationDate;
  String? category;
  String? status;
  String? communicationMethod;
  City? city;
  User? user;
  String? imageUrl;
  String? telegramLink;
  String? whatsappLink;
  String? qrCode;
  int? reputation;
  FoodUnit? foodUnit;
  int? quantity;
  String? foodExpirationDate;

  FoodDonationResponse(
      {this.id,
      this.active,
      this.title,
      this.description,
      this.donationDate,
      this.donationExpirationDate,
      this.category,
      this.status,
      this.communicationMethod,
      this.city,
      this.user,
      this.imageUrl,
      this.telegramLink,
      this.whatsappLink,
      this.qrCode,
      this.reputation,
      this.foodUnit,
      this.quantity,
      this.foodExpirationDate});

  FoodDonationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    title = json['title'];
    description = json['description'];
    donationDate = json['donation_date'];
    donationExpirationDate = json['donation_expiration_date'];
    category = json['category'];
    status = json['status'];
    communicationMethod = json['communication_method'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    imageUrl = json['image_url'];
    telegramLink = json['telegram_link'];
    whatsappLink = json['whatsapp_link'];
    qrCode = json['qr_code'];
    reputation = json['reputation'];
    foodUnit = json['food_unit'] != null
        ? new FoodUnit.fromJson(json['food_unit'])
        : null;
    quantity = json['quantity'];
    foodExpirationDate = json['food_expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
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
    if (this.foodUnit != null) {
      data['food_unit'] = this.foodUnit!.toJson();
    }
    data['quantity'] = this.quantity;
    data['food_expiration_date'] = this.foodExpirationDate;
    return data;
  }
}
