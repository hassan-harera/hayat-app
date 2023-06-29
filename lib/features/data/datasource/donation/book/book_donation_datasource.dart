import 'dart:convert';

import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/error/exceptions.dart';
import '../../../../../core/error/api_error.dart';

class BookDonationDataSource {
  final String apiUrl = 'http://146.190.206.136:8080/api/v1/donations/book';
  final http.Client client;

  BookDonationDataSource({required this.client});

  Future<BookDonationResponse?> create(BookDonationRequest request) async {
    final response = await client
        .post(Uri.parse(apiUrl), body: jsonEncode(request.toJson()), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BookDonationResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
