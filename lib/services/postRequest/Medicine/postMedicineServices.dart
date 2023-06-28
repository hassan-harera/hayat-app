
import '../../../helper/helper.dart';
import '../../../models/Medicine/postMedicine.dart';


class PostMedicineDonation {
  Future<PostMedicine> postMedicineDonation({
required int? quantity,
required int? cityId,
required String? communicationMethod,
required String? description,
required String? title,
required String? bookTitle,
required int? foodUnitId,
required int? foodCategoryId,
required String? foodExpirationDate,
required String? telegramLink,
    required String? token,
  }) async {
    Map<String, dynamic> data = await Api().post(
      url: 'http://64.225.6.213:8080/api/v1/donations/medicine',
      body: {
        'quantity': quantity,
        'city_id': cityId,
        'communication_method': communicationMethod,
        'description': description,
        'title': title,
        'book_title': bookTitle,
        'food_unit_id': foodUnitId,
        'food_category_id': foodCategoryId,
        'food_expiration_date': foodExpirationDate,
        'telegram_link': telegramLink,

      },
      token: token,
    );

    return PostMedicine.fromJson(data);
  }
}
