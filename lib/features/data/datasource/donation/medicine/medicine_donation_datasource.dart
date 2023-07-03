import 'dart:convert';

import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_response.dart';
import 'package:hayat_eg/features/data/model/medicine_donation.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/error/exceptions.dart';
import '../../../../../core/error/api_error.dart';

class MedicineDonationDataSource {
  final http.Client client;

  MedicineDonationDataSource({required this.client});

  Future<MedicineDonationResponse?> create(
      MedicineDonationRequest medicine) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(
        Uri.parse("$baseUrl/api/v1/donations/medicine"),
        body: jsonEncode(medicine.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<List<MedicineDonationResponse>?> search(String query) async {
    final response =
        await client.get(Uri.parse("$baseUrl/api/v1/donations/medicine"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<MedicineDonationResponse>.from(decodeJson(response.body)
          .map((e) => MedicineDonationResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
