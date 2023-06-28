import 'package:hayat_eg/features/data/datasource/donation/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/donations_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';

class BookDonationRepository {
  final DonationDataSource donationDataSource;

  BookDonationRepository({
    required this.donationDataSource,
  });

  Future<List<DonationResponse>?> search(String query) async {
    return await donationDataSource.search(query);
  }
}
