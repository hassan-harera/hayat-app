import 'package:hayat_eg/core/error/api_error.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/model/user/user.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:http/http.dart' as http;

class ProfileDataSource {
  final http.Client client;

  ProfileDataSource({required this.client});

  Future<User?> getProfile() async {
    final token = Cash_helper.getData(key: 'token');
    final response =
        await client.get(Uri.parse("$baseUrl/api/v1/me"), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(decodeJson(response.body));
    } else if (response.statusCode == 400) {
      throw BadRequestException(
          apiError: ApiError.fromJson(decodeJson(response.body)));
    }
  }
}
