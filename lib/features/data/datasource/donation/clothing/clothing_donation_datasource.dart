import 'dart:convert';

import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;

class ClothingDonationDataSource {
  final String apiUrl = 'http://146.190.206.136:8080/api/v1/donations/clothing';
  final http.Client client;

  ClothingDonationDataSource({required this.client});

  Future<BookDonationResponse?> create(ClothingDonationRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse(apiUrl),
        body: jsonEncode(request.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BookDonationResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
