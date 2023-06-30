class BookNeedRequest {
  int? quantity;
  int? cityId;
  String? communicationMethod;
  String? description;
  String? title;
  String? telegramLink;

  BookNeedRequest(
      {this.quantity,
      this.cityId,
      this.communicationMethod,
      this.description,
      this.title,
      this.telegramLink});

  BookNeedRequest.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    cityId = json['city_id'];
    communicationMethod = json['communication_method'];
    description = json['description'];
    title = json['title'];
    telegramLink = json['telegram_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['city_id'] = this.cityId;
    data['communication_method'] = this.communicationMethod;
    data['description'] = this.description;
    data['title'] = this.title;
    data['telegram_link'] = this.telegramLink;
    return data;
  }
}
