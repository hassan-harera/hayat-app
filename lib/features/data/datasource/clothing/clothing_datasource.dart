import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_condition.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_seasson.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart' as http;

class ClothingDatasource {
  final http.Client client;

  ClothingDatasource(this.client);

  Future<List<ClothingSize>> listClothingSizes() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/clothing/sizes'));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingSize>.from(data.map((e) => ClothingSize.fromJson(e)));
  }

  Future<List<ClothingCategory>> listClothingCategories() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/clothing/categories'));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingCategory>.from(
        data.map((e) => ClothingCategory.fromJson(e)));
  }

  Future<List<ClothingType>> listClothingTypes() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/clothing/types'));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingType>.from(data.map((e) => ClothingType.fromJson(e)));
  }

  Future<List<ClothingSeason>> listClothingSeason() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/clothing/seasons'));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingSeason>.from(
        data.map((e) => ClothingSeason.fromJson(e)));
  }

  Future<List<ClothingCondition>> listClothingCondition() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/clothing/conditions'));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingCondition>.from(
        data.map((e) => ClothingCondition.fromJson(e)));
  }
}
