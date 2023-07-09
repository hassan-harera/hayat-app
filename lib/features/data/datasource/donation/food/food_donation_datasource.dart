import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FoodDonationDataSource {
  final http.Client client;

  FoodDonationDataSource(this.client);

  Future<FoodDonationResponse?> create(FoodDonationRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(
        Uri.parse('$baseUrl/api/v1/donations/food'),
        body: jsonEncode(request.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FoodDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<List<FoodDonationResponse>?> search(String query) async {
    final response =
        await client.get(Uri.parse("$baseUrl/api/v1/donations/food/results?q=$query"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<FoodDonationResponse>.from(decodeJson(response.body)
          .map((e) => FoodDonationResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<FoodDonationResponse?> get(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/api/v1/donations/food/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FoodDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<FoodDonationResponse?> upvote(int id) async {
    final response = await client
        .put(Uri.parse('$baseUrl/api/v1/donations/food/$id/upvote'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
    });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<FoodDonationResponse?> downvote(int id) async {
    final response = await client.put(
        Uri.parse('$baseUrl/api/v1/donations/food/$id/down-vote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
        });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<FoodDonationResponse?> updateImage(int id, Uint8List file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/api/v1/donations/book/$id/images'));

    request.files.add(http.MultipartFile.fromBytes('file', file,
        filename: 'image.jpg', contentType: MediaType('image', 'jpg')));
    request.headers
        .assign('Authorization', 'Bearer ${Cash_helper.getData(key: 'token')}');

    var response = await request.send();
    final body = (await response.stream.bytesToString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FoodDonationResponse.fromJson(decodeJson(body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(apiError: ApiError.fromJson(jsonDecode(body)));
    }
  }
}
