import 'dart:ffi';
import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/donation/food/food_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_response.dart';

class FoodDonationRepository {
  final FoodDonationDataSource foodDonationDataSource;

  FoodDonationRepository({
    required this.foodDonationDataSource,
  });

  Future<FoodDonationResponse?> create(FoodDonationRequest request) async {
    return await foodDonationDataSource.create(request);
  }

  Future<List<FoodDonationResponse>?> search(String query) async {
    return await foodDonationDataSource.search(query);
  }

  Future<FoodDonationResponse?> get(int id) async {
    return await foodDonationDataSource.get(id);
  }

  Future<FoodDonationResponse?> upvote(int id) async {
    return await foodDonationDataSource.upvote(id);
  }

  Future<FoodDonationResponse?> downvote(int id) async {
    return await foodDonationDataSource.downvote(id);
  }

  Future<FoodDonationResponse?> updateImage(int id, Uint8List image) async {
    return await foodDonationDataSource.updateImage(id, image);
  }
}
