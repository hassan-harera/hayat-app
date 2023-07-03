import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_condition.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_seasson.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';

class ClothingDatasource {
  Future<List<ClothingSize>> listClothingSizes() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/sizes');
    return List<ClothingSize>.from(data.map((e) => ClothingSize.fromJson(e)));
  }

  Future<List<ClothingCategory>> listClothingCategories() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/clothing/categories');
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

  Future<List<ClothingSeason>> listClothingSeason() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/clothing/seasons');
    List<ClothingSeason> clothesSeason = [];
    for (int i = 0; i < data.length; i++) {
      clothesSeason.add(
        ClothingSeason.fromJson(data[i]),
      );
    }
    return clothesSeason;
  }

  Future<List<ClothingCondition>> listClothingCondition() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/clothing/conditions');
    List<ClothingCondition> clothesCondition = [];
    for (int i = 0; i < data.length; i++) {
      clothesCondition.add(
        ClothingCondition.fromJson(data[i]),
      );
    }
    return clothesCondition;
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
