import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';

class BookDonationRepository {
  final BookDonationDataSource bookDonationDataSource;

  BookDonationRepository({
    required this.bookDonationDataSource,
  });

  Future<ClothingDonationResponse?> create(BookDonationRequest request) async {
    return await bookDonationDataSource.create(request);
  }
}
