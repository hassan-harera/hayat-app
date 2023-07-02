class FoodDonationRequest {
  double? quantity;
  int? cityId;
  String? communicationMethod;
  String? description;
  String? state;
  String? title;
  int? foodUnitId;
  int? foodCategoryId;
  String? foodExpirationDate;
  String? telegramLink;
  String? whatsappLink;

  FoodDonationRequest(
      {this.quantity,
      this.cityId,
      this.communicationMethod,
      this.description,
      this.state,
      this.title,
      this.foodUnitId,
      this.foodCategoryId,
      this.foodExpirationDate,
      this.telegramLink,
      this.whatsappLink});

  FoodDonationRequest.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    cityId = json['city_id'];
    communicationMethod = json['communication_method'];
    description = json['description'];
    state = json['state'];
    title = json['title'];
    foodUnitId = json['food_unit_id'];
    foodCategoryId = json['food_category_id'];
    foodExpirationDate = json['food_expiration_date'];
    telegramLink = json['telegram_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['city_id'] = this.cityId;
    data['communication_method'] = this.communicationMethod;
    data['description'] = this.description;
    data['state'] = this.state;
    data['title'] = this.title;
    data['food_unit_id'] = this.foodUnitId;
    data['food_category_id'] = this.foodCategoryId;
    data['food_expiration_date'] = this.foodExpirationDate;
    data['telegram_link'] = this.telegramLink;
    return data;
  }
}
