class Donation {
  String? id;
  bool? active;
  String? title;
  String? description;
  String? needDate;
  String? needExpirationDate;
  String? category;
  String? status;
  String? communicationMethod;
  Null? imageUrl;
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

  Donation(
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

  Donation.fromJson(Map<String, dynamic> json) {
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

class City {
  int? id;
  String? arabicName;
  String? englishName;
  State? state;

  City({this.id, this.arabicName, this.englishName, this.state});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

class State {
  int? id;
  String? arabicName;
  String? englishName;

  State({this.id, this.arabicName, this.englishName});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
