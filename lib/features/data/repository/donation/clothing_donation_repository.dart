import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/clothing/clothing_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';

class ClothingDonationRepository {
  final ClothingDonationDataSource clothingDonationDataSource;

  ClothingDonationRepository({
    required this.clothingDonationDataSource,
  });

  Future<ClothingDonationResponse?> create(
      ClothingDonationRequest request) async {
    return await clothingDonationDataSource.create(request);
  }
}
