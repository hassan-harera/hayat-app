class MedicineDonationRequest {
  String? title;
  String? description;
  String? donationDate;
  String? donationExpirationDate;
  String? category;
  String? status;
  String? communicationMethod;
  int? cityId;
  String? imageUrl;
  String? telegramLink;
  String? whatsappLink;
  String? qrCode;
  int? reputation;
  int? quantity;
  MedicineUnit? medicineUnit;
  String? medicineExpirationDate;
  int? medicineUnitId;
  int? medicineId;
  int? unitId;

  MedicineDonationRequest(
      {this.quantity,
      this.cityId,
      this.communicationMethod,
      this.description,
      this.title,
      this.bookTitle,
      this.foodUnitId,
      this.foodCategoryId,
      this.foodExpirationDate,
      this.telegramLink});

  MedicineDonationRequest.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    cityId = json['city_id'];
    communicationMethod = json['communication_method'];
    description = json['description'];
    title = json['title'];
    bookTitle = json['book_title'];
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
    data['title'] = this.title;
    data['book_title'] = this.bookTitle;
    data['food_unit_id'] = this.foodUnitId;
    data['food_category_id'] = this.foodCategoryId;
    data['food_expiration_date'] = this.foodExpirationDate;
    data['telegram_link'] = this.telegramLink;
    return data;
  }
}
