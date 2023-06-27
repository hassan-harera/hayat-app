class MedicineDonation {
  final String title;
  final String description;
  final String communicationMethod;
  final int cityId;
  final int quantity;
  final DateTime expirationDate;
  final int medicineUnitId;
  final int medicineId;

  MedicineDonation({
    required this.title,
    required this.description,
    required this.communicationMethod,
    required this.cityId,
    required this.quantity,
    required this.expirationDate,
    required this.medicineUnitId,
    required this.medicineId,
  });

  factory MedicineDonation.fromJson(Map<String, dynamic> json) {
    return MedicineDonation(
      title: json['title'] as String,
      description: json['description'] as String,
      communicationMethod: json['communication_method'] as String,
      cityId: json['city_id'] as int,
      quantity: json['quantity'] as int,
      expirationDate: DateTime.parse(json['medicine_expiration_date'] as String),
      medicineUnitId: json['medicine_unit_id'] as int,
      medicineId: json['medicine_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'communication_method': communicationMethod,
      'city_id': cityId,
      'quantity': quantity,
      'medicine_expiration_date': expirationDate.toIso8601String(),
      'medicine_unit_id': medicineUnitId,
      'medicine_id': medicineId,
    };
  }
}
