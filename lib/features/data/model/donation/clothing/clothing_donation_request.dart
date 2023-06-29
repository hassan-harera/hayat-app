class ClothingDonationRequest {
  String? title;
  String? description;
  String? communicationMethod;
  int? cityId;
  String? imageUrl;
  String? telegramLink;
  String? qrCode;
  int? quantity;
  int? clothingConditionId;
  int? clothingSeasonId;
  int? clothingTypeId;
  int? clothingCategoryId;

  ClothingDonationRequest(
      {this.title,
      this.description,
      this.communicationMethod,
      this.cityId,
      this.imageUrl,
      this.telegramLink,
      this.qrCode,
      this.quantity,
      this.clothingConditionId,
      this.clothingSeasonId,
      this.clothingTypeId,
      this.clothingCategoryId});

  ClothingDonationRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    communicationMethod = json['communication_method'];
    cityId = json['city_id'];
    imageUrl = json['image_url'];
    telegramLink = json['telegram_link'];
    qrCode = json['qr_code'];
    quantity = json['quantity'];
    clothingConditionId = json['clothing_condition_id'];
    clothingSeasonId = json['clothing_season_id'];
    clothingTypeId = json['clothing_type_id'];
    clothingCategoryId = json['clothing_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['communication_method'] = this.communicationMethod;
    data['city_id'] = this.cityId;
    data['image_url'] = this.imageUrl;
    data['telegram_link'] = this.telegramLink;
    data['qr_code'] = this.qrCode;
    data['quantity'] = this.quantity;
    data['clothing_condition_id'] = this.clothingConditionId;
    data['clothing_season_id'] = this.clothingSeasonId;
    data['clothing_type_id'] = this.clothingTypeId;
    data['clothing_category_id'] = this.clothingCategoryId;
    return data;
  }
}
