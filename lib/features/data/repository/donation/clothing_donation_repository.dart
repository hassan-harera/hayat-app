import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/donation/clothing/clothing_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_response.dart';

class ClothingDonationRepository {
  final ClothingDonationDataSource _clothingDonationDataSource;

  ClothingDonationRepository({
    required ClothingDonationDataSource clothingDonationDataSource,
  }) : _clothingDonationDataSource = clothingDonationDataSource;

  Future<ClothingDonationResponse?> create(ClothingDonationRequest request) async {
    return await _clothingDonationDataSource.create(request);
  }
  
  Future<ClothingDonationResponse?> updateImage(int id, Uint8List image) async {
    return await _clothingDonationDataSource.updateImage(id, image);
  }

  Future<List<ClothingDonationResponse>?> search(String query) async {
    return await _clothingDonationDataSource.search(query);
  }
}
