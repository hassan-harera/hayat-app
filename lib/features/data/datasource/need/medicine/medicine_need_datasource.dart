import 'dart:convert';

import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/features/data/model/need/medicine/medicine_need_request.dart';
import 'package:hayat_eg/features/data/model/need/medicine/medicine_need_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;

class MedicineNeedDataSource {
  final http.Client client;

  MedicineNeedDataSource({required this.client});

  Future<MedicineNeedResponse?> create(MedicineNeedRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse("$baseUrl/api/v1/needs/medicine"),
        body: request.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineNeedResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<List<MedicineNeedResponse>?> search(String query) async {
    final response = await client
        .get(Uri.parse("$baseUrl/api/v1/needs/medicine"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<MedicineNeedResponse>.from(
          decodeJson(response.body).map((e) => MedicineNeedResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
