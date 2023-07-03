import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ClothingDonationDataSource {
  final http.Client client;

  ClothingDonationDataSource(this.client);

  Future<ClothingDonationResponse?> create(
      ClothingDonationRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse('$baseUrl/api/v1/donations/clothing'),
        body: jsonEncode(request.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ClothingDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<List<ClothingDonationResponse>?> search(String query) async {
    final response =
    await client.get(Uri.parse("$baseUrl/api/v1/donations/clothing"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<ClothingDonationResponse>.from(decodeJson(response.body)
          .map((e) => ClothingDonationResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<ClothingDonationResponse?> get(int id) async {
    final response =
    await client.get(Uri.parse('$baseUrl/api/v1/donations/clothing/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ClothingDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<ClothingDonationResponse?> upvote(int id) async {
    final response = await client.put(
        Uri.parse('$baseUrl/api/v1/donations/clothing/$id/upvote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
        });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<ClothingDonationResponse?> downvote(int id) async {
    final response = await client.put(
        Uri.parse('$baseUrl/api/v1/donations/clothing/$id/down-vote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
        });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<ClothingDonationResponse?> updateImage(int id, Uint8List file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/api/v1/donations/book/$id/images'));

    request.files.add(http.MultipartFile.fromBytes('file', file,
        filename: 'image.jpg', contentType: MediaType('image', 'jpg')));
    request.headers
        .assign('Authorization', 'Bearer ${Cash_helper.getData(key: 'token')}');

    var response = await request.send();
    final body = (await response.stream.bytesToString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ClothingDonationResponse.fromJson(decodeJson(body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(apiError: ApiError.fromJson(jsonDecode(body)));
    }
  }
}
