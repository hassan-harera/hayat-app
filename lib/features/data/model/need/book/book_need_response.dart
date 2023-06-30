import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';

class BookNeedResponse {
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
  String? bookTitle;
  String? bookSubTitle;
  String? bookAuthor;
  String? bookPublisher;
  String? bookPublicationYear;
  String? bookLanguage;

  BookNeedResponse(
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
      this.bookTitle,
      this.bookSubTitle,
      this.bookAuthor,
      this.bookPublisher,
      this.bookPublicationYear,
      this.bookLanguage});

  BookNeedResponse.fromJson(Map<String, dynamic> json) {
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
    bookTitle = json['book_title'];
    bookSubTitle = json['book_sub_title'];
    bookAuthor = json['book_author'];
    bookPublisher = json['book_publisher'];
    bookPublicationYear = json['book_publication_year'];
    bookLanguage = json['book_language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['book_title'] = this.bookTitle;
    data['book_sub_title'] = this.bookSubTitle;
    data['book_author'] = this.bookAuthor;
    data['book_publisher'] = this.bookPublisher;
    data['book_publication_year'] = this.bookPublicationYear;
    data['book_language'] = this.bookLanguage;
    return data;
  }
}
