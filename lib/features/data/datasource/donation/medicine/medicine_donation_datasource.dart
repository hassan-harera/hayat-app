import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_response.dart';
import 'package:hayat_eg/features/data/model/medicine_donation.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../../../core/error/exceptions.dart';
import '../../../../../core/error/api_error.dart';

class MedicineDonationDataSource {
  final http.Client client;

  MedicineDonationDataSource({required this.client});

  Future<MedicineDonationResponse?> create(
      MedicineDonationRequest request) async {
    String token = Cash_helper.getData(key: 'token');
    final response = await client.post(Uri.parse('$baseUrl/api/v1/donations/medicine'),
        body: jsonEncode(request.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
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

  Future<MedicineDonationResponse?> get(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/api/v1/donations/medicine/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineDonationResponse.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<MedicineDonationResponse?> upvote(int id) async {
    final response = await client.put(
        Uri.parse('$baseUrl/api/v1/donations/medicine/$id/upvote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
        });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<MedicineDonationResponse?> downvote(int id) async {
    final response = await client.put(
        Uri.parse('$baseUrl/api/v1/donations/medicine/$id/down-vote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Cash_helper.getData(key: 'token')}'
        });

    if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }

  Future<MedicineDonationResponse?> updateImage(int id, Uint8List file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/api/v1/donations/book/$id/images'));

    request.files.add(http.MultipartFile.fromBytes('file', file,
        filename: 'image.jpg', contentType: MediaType('image', 'jpg')));
    request.headers
        .assign('Authorization', 'Bearer ${Cash_helper.getData(key: 'token')}');

    var response = await request.send();
    final body = decodeJson(await response.stream.bytesToString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MedicineDonationResponse.fromJson(jsonDecode(body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(apiError: ApiError.fromJson(jsonDecode(body)));
    }
  }
}
