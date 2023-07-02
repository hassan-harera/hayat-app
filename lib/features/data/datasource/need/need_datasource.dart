import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart' as http;

class NeedDataSource {
  final http.Client client;

  NeedDataSource({required this.client});

  Future<List<NeedResponse>?> search(String query) async {
    final response = await client
        .get(Uri.parse("$baseUrl/api/v1/needs/results?q=$query"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<NeedResponse>.from(
          decodeJson(response.body).map((e) => NeedResponse.fromJson(e)));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }
}
