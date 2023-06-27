import 'dart:convert';

import 'package:hayat_eg/features/data/model/medicine_donation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/error/api_error.dart';

class MedicineDonationDataSource {
  final String apiUrl = 'http://64.225.6.213:8080/api/v1/donations/medicine';
  final http.Client client;

  MedicineDonationDataSource({required this.client});

  Future<MedicineDonation?> postMedicineDonation(
      MedicineDonation medicine) async {
    final response = await client
        .post(Uri.parse(apiUrl), body: jsonEncode(medicine.toJson()), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineDonation.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
