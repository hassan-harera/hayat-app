import 'package:hayat_eg/features/data/model/clothing/clothesCategory.dart';
import 'package:hayat_eg/features/data/model/clothing/clothesSize.dart';
import 'package:hayat_eg/features/data/model/clothing/clothesType.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';

class ClothesServices {
  Future<List<ClothesSize>> getClothesSize() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/sizes');
    List<ClothesSize> clothesSize = [];
    for (int i = 0; i < data.length; i++) {
      clothesSize.add(
        ClothesSize.fromJson(data[i]),
      );
    }
    return clothesSize;
  }

  Future<List<ClothesCategory>> getClothesCategory() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/clothing/categories');
    List<ClothesCategory> clothesCategory = [];
    for (int i = 0; i < data.length; i++) {
      clothesCategory.add(
        ClothesCategory.fromJson(data[i]),
      );
    }
    return clothesCategory;
  }

  Future<List<ClothesType>> getClothesType() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/types');
    List<ClothesType> clothesType = [];
    for (int i = 0; i < data.length; i++) {
      clothesType.add(
        ClothesType.fromJson(data[i]),
      );
    }
    return clothesType;
  }

  Future<List<MedicineModel>> getListMedicineName() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/medicines');
    List<MedicineModel> listMedicine = [];
    for (int i = 0; i < data.length; i++) {
      listMedicine.add(MedicineModel.fromJson(data[i]));
    }

    print(data);
    return listMedicine;
  }
}
