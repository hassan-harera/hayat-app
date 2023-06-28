import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/error/api_error.dart';
import '../model/city/city.dart';

class CityDataSource {
  final String apiUrl = 'http://146.190.206.136:8080/api/v1/cities';
  final http.Client client;

  CityDataSource({required this.client});

  Future<City?> get(int id) async {
    final response =
        await client.get(Uri.parse(apiUrl + id.toString()), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return City.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }

  Future<List<City>?> search(String query) async {
    final response = await client.get(Uri.parse("$apiUrl/search?q=$query"));
    if (response.statusCode == 200) {
      List<dynamic> data = List<dynamic>.from(jsonDecode(response.body));
      return List<City>.from(data.map((json) => City.fromJson(json)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(jsonDecode(response.body)));
    }
  }
}
