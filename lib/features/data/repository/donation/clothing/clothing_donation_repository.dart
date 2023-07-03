import 'dart:ffi';
import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/donation/clothing/clothing_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_response.dart';

class ClothingDonationRepository {
  final ClothingDonationDataSource clothingDonationDataSource;

  ClothingDonationRepository({
    required this.clothingDonationDataSource,
  });

  Future<ClothingDonationResponse?> create(
      ClothingDonationRequest request) async {
    return await clothingDonationDataSource.create(request);
  }

  Future<List<ClothingDonationResponse>?> search(String query) async {
    return await clothingDonationDataSource.search(query);
  }

  Future<ClothingDonationResponse?> get(int id) async {
    return await clothingDonationDataSource.get(id);
  }

  Future<ClothingDonationResponse?> upvote(int id) async {
    return await clothingDonationDataSource.upvote(id);
  }

  Future<ClothingDonationResponse?> downvote(int id) async {
    return await clothingDonationDataSource.downvote(id);
  }

  Future<ClothingDonationResponse?> updateImage(int id, Uint8List image) async {
    return await clothingDonationDataSource.updateImage(id, image);
  }
}
