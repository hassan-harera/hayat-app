class BookDonationRequest {
  String title;
  String? description;
  String communicationMethod;
  int? cityId;
  String? telegramLink;
  String? whatsappLink;
  int? quantity;
  String? bookTitle;
  String? bookSubTitle;
  String? bookAuthor;
  String? bookPublisher;
  String? bookPublicationYear;
  String? bookLanguage;

  BookDonationRequest({required this.title,
    this.description,
    required this.communicationMethod,
    required this.cityId,
    this.telegramLink,
    this.whatsappLink,
    this.quantity,
    this.bookTitle,
    this.bookSubTitle,
    this.bookAuthor,
    this.bookPublisher,
    this.bookPublicationYear,
    this.bookLanguage});

  BookDonationRequest fromJson(Map<String, dynamic> json) {
    return BookDonationRequest(
        title: json['title'] as String,
        description: json['description'] as String,
        communicationMethod: json['communication_method'] as String,
        cityId: json['city_id'] as int,
        telegramLink: json['telegram_link'] as String,
        whatsappLink: json['whatsapp_link'] as String,
        quantity: json['quantity'] as int,
        bookTitle: json['book_title'] as String,
        bookSubTitle: json['book_sub_title'] as String,
        bookAuthor: json['book_author'] as String,
        bookPublisher: json['book_publisher'] as String,
        bookPublicationYear: json['book_publication_year'] as String,
        bookLanguage: json['book_language'] as String
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['communication_method'] = this.communicationMethod;
    data['city_id'] = this.cityId;
    data['telegram_link'] = this.telegramLink;
    data['whatsapp_link'] = this.whatsappLink;
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
