import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class DonationDataSource {
  final String apiUrl = 'http://146.190.206.136:8080/api/v1/donations';
  final http.Client client;

  DonationDataSource({required this.client});

  Future<List<DonationResponse>?> search(String query) async {
    final response = await client.get(Uri.parse("$apiUrl/results?q=$query"));
    List<dynamic> data = List<dynamic>.from(decodeJson(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<DonationResponse>.from(
          data.map((json) => DonationResponse.fromJson(json)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

}
