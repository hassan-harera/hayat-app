import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_seasson.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class ClothingDonationResponse {
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
  int? quantity;
  ClothingSeason? clothingSeason;
  ClothingSize? clothingCondition;
  ClothingSize? clothingSize;
  ClothingCategory? clothingCategory;
  ClothingType? clothingType;

  ClothingDonationResponse(
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
      this.quantity,
      this.clothingSeason,
      this.clothingCondition,
      this.clothingSize,
      this.clothingCategory,
      this.clothingType});

  ClothingDonationResponse.fromJson(Map<String, dynamic> json) {
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
    quantity = json['quantity'];
    clothingSeason = json['clothing_season'] != null
        ? ClothingSeason.fromJson(json['clothing_season'])
        : null;
    clothingCondition = json['clothing_condition'] != null
        ? ClothingSize.fromJson(json['clothing_condition'])
        : null;
    clothingSize = json['clothing_size'];
    clothingCategory = json['clothing_category'] != null
        ? ClothingCategory.fromJson(json['clothing_category'])
        : null;
    clothingType = json['clothing_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['quantity'] = this.quantity;
    if (this.clothingSeason != null) {
      data['clothing_season'] = this.clothingSeason!.toJson();
    }
    if (this.clothingCondition != null) {
      data['clothing_condition'] = this.clothingCondition!.toJson();
    }
    data['clothing_size'] = this.clothingSize;
    if (this.clothingCategory != null) {
      data['clothing_category'] = this.clothingCategory!.toJson();
    }
    data['clothing_type'] = this.clothingType;
    return data;
  }
}
