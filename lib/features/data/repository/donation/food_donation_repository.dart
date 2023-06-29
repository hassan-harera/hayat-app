import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/food/food_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_response.dart';

class FoodDonationRepository {
  final FoodDonationDatasource foodDonationDataSource;

  FoodDonationRepository({
    required this.foodDonationDataSource,
  });

  Future<FoodDonationResponse?> create(FoodDonationRequest request) async {
    return await foodDonationDataSource.create(request);
  }
}
