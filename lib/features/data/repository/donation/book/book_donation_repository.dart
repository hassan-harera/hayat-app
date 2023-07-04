import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';

class BookDonationRepository {
  final BookDonationDataSource bookDonationDataSource;

  BookDonationRepository({
    required this.bookDonationDataSource,
  });

  Future<BookDonationResponse?> create(
      BookDonationRequest request) async {
    return await bookDonationDataSource.create(request);
  }

  Future<List<BookDonationResponse>?> search(String query) async {
    return await bookDonationDataSource.search(query);
  }

  Future<BookDonationResponse?> get(int id) async {
    return await bookDonationDataSource.get(id);
  }

  Future<BookDonationResponse?> upvote(int id) async {
    return await bookDonationDataSource.upvote(id);
  }

  Future<BookDonationResponse?> downvote(int id) async {
    return await bookDonationDataSource.downvote(id);
  }

  Future<BookDonationResponse?> updateImage(int id, Uint8List image) async {
    return await bookDonationDataSource.updateImage(id, image);
  }
}
