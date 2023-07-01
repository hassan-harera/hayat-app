import 'dart:convert';

import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_request.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;

class BookNeedDataSource {
  final http.Client client;

  BookNeedDataSource({required this.client});

  Future<BookNeedResponse?> create(BookNeedRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse("$baseUrl/api/v1/needs/book"),
        body: request.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BookNeedResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<List<BookNeedResponse>?> search(String query) async {
    final response = await client
        .get(Uri.parse("$baseUrl/api/v1/needs/book/results?query=$query"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<BookNeedResponse>.from(
          jsonDecode(response.body).map((e) => BookNeedResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
