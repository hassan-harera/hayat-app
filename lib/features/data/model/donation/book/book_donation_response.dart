import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class BookDonationResponse extends DonationResponse {
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
  String? bookTitle;
  String? bookSubTitle;
  String? bookAuthor;
  String? bookPublisher;
  String? bookPublicationYear;
  String? bookLanguage;

  BookDonationResponse(
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
      this.bookTitle,
      this.bookSubTitle,
      this.bookAuthor,
      this.bookPublisher,
      this.bookPublicationYear,
      this.bookLanguage});

  BookDonationResponse.fromJson(Map<String, dynamic> json) {
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
    quantity = json['quantity'];
    bookTitle = json['book_title'];
    bookSubTitle = json['book_sub_title'];
    bookAuthor = json['book_author'];
    bookPublisher = json['book_publisher'];
    bookPublicationYear = json['book_publication_year'];
    bookLanguage = json['book_language'];
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
    data['quantity'] = this.quantity;
    data['book_title'] = this.bookTitle;
    data['book_sub_title'] = this.bookSubTitle;
    data['book_author'] = this.bookAuthor;
    data['book_publisher'] = this.bookPublisher;
    data['book_publication_year'] = this.bookPublicationYear;
    data['book_language'] = this.bookLanguage;
    return data;
  }
}
