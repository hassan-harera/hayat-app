class BookNeedRequest {
  String? title;
  String? description;
  String? communicationMethod;
  int? cityId;
  String? bookTitle;
  String? bookSubTitle;
  String? bookAuthor;
  String? bookPublisher;
  String? bookPublicationYear;
  String? bookLanguage;

  BookNeedRequest(
      {this.title,
      this.description,
      this.communicationMethod,
      this.cityId,
      this.bookTitle,
      this.bookSubTitle,
      this.bookAuthor,
      this.bookPublisher,
      this.bookPublicationYear,
      this.bookLanguage});

  BookNeedRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    communicationMethod = json['communication_method'];
    cityId = json['city_id'];
    bookTitle = json['book_title'];
    bookSubTitle = json['book_sub_title'];
    bookAuthor = json['book_author'];
    bookPublisher = json['book_publisher'];
    bookPublicationYear = json['book_publication_year'];
    bookLanguage = json['book_language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['communication_method'] = this.communicationMethod;
    data['city_id'] = this.cityId;
    data['book_title'] = this.bookTitle;
    data['book_sub_title'] = this.bookSubTitle;
    data['book_author'] = this.bookAuthor;
    data['book_publisher'] = this.bookPublisher;
    data['book_publication_year'] = this.bookPublicationYear;
    data['book_language'] = this.bookLanguage;
    return data;
  }
}
