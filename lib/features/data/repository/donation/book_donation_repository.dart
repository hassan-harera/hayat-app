import 'package:flutter/foundation.dart';
import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';

class BookDonationRepository {
  final BookDonationDataSource bookDonationDataSource;

  BookDonationRepository({
    required this.bookDonationDataSource,
  });

  Future<BookDonationResponse?> create(BookDonationRequest request) async {
    return await bookDonationDataSource.create(request);
  }

  Future<BookDonationResponse?> updateImage(int id, Uint8List image) async {
    return await bookDonationDataSource.updateImage(id, image);
  }

  Future<List<BookDonationResponse>?> search(String query) async {
    return await bookDonationDataSource.search(query);
  }
}
