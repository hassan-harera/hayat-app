import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/need/blood/blood_need_request.dart';
import 'package:hayat_eg/features/data/model/need/blood/blood_need_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class BloodNeedDataSource {
  final http.Client client;

  BloodNeedDataSource(this.client);

  Future<BloodNeedResponse?> create(BloodNeedRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse('$baseUrl/api/v1/needs/blood'),
        body: jsonEncode(request.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    print(token);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return BloodNeedResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<List<BloodNeedResponse>?> search(String query) async {
    final response = await client.get(Uri.parse("$baseUrl/api/v1/needs/blood"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<BloodNeedResponse>.from(
          decodeJson(response.body).map((e) => BloodNeedResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<BloodNeedResponse?> get(String id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/api/v1/needs/blood/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BloodNeedResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<BloodNeedResponse?> upvote(int id) async {
    final response = await client
        .put(Uri.parse('$baseUrl/api/v1/needs/blood/$id/upvote'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
    });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<BloodNeedResponse?> downvote(int id) async {
    final response = await client
        .put(Uri.parse('$baseUrl/api/v1/needs/blood/$id/down-vote'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
    });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<BloodNeedResponse?> updateImage(String id, Uint8List file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/api/v1/needs/blood/$id/images'));

    request.files.add(http.MultipartFile.fromBytes('file', file,
        filename: 'image.jpg', contentType: MediaType('image', 'jpg')));
    request.headers
        .assign('Authorization', 'Bearer ${Cash_helper.getData(key: 'token')}');

    var response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BloodNeedResponse.fromJson(decodeJson(body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(apiError: ApiError.fromJson(decodeJson(body)));
    }
  }
}
