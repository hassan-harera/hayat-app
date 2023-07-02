import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
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
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/sizes');
    return List<ClothingSize>.from(data.map((e) => ClothingSize.fromJson(e)));
  }

  Future<List<ClothingCategory>> listClothingCategories() async {
    var response =
        await client.get(Uri.parse("$baseUrl/api/v1/clothing/categories"));
    List<dynamic> data = decodeJson(response.body);
    return List<ClothingCategory>.from(
        data.map((e) => ClothingCategory.fromJson(e)));
  }

  Future<List<ClothingType>> listClothingTypes() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/types');
    List<ClothingType> clothesType = [];
    for (int i = 0; i < data.length; i++) {
      clothesType.add(
        ClothingType.fromJson(data[i]),
      );
    }
    return clothesType;
  }

  Future<List<Medicine>> getListMedicineName() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/medicines');
    List<Medicine> listMedicine = [];
    for (int i = 0; i < data.length; i++) {
      listMedicine.add(Medicine.fromJson(data[i]));
    }

    print(data);
    return listMedicine;
  }
}
