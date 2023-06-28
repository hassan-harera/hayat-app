import 'dart:ffi';

class DonationResponse {
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
  Int? reputation;

  DonationResponse(
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
      this.reputation});

  DonationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
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
    return data;
  }
}

class City {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;

  City({this.id, this.active, this.arabicName, this.englishName});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  Null? email;
  String? password;
  String? username;
  String? deviceToken;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.password,
      this.username,
      this.deviceToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['username'] = this.username;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}
