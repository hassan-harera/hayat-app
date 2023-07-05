import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart' as http;

class FoodDataSource {
  final http.Client client;

  FoodDataSource({required this.client});

  Future<List<FoodCategory>> listFoodCategories() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/food/categories'));
    List<dynamic> data = decodeJson(response.body);
    return List<FoodCategory>.from(data.map((e) => FoodCategory.fromJson(e)));
  }

  Future<List<FoodUnit>> listFoodUnits() async {
    var response = await client.get(Uri.parse('$baseUrl/api/v1/food/units'));
    List<dynamic> data = decodeJson(response.body);
    return List<FoodUnit>.from(data.map((e) => FoodUnit.fromJson(e)));
  }
}
