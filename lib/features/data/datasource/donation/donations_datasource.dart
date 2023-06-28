import 'dart:convert';

import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:http/http.dart' as http;

class DonationDataSource {
  final String apiUrl = 'http://146.190.206.136:8080/api/v1/donations';
  final http.Client client;

  DonationDataSource({required this.client});

  Future<List<DonationResponse>?> search(String query) async {
    final response = await client.post(Uri.parse("$apiUrl/results?q=$query"));
    List<dynamic> data = List<dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<DonationResponse>.from(
          data.map((json) => DonationResponse.fromJson(json)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
