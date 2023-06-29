import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/model/medicineModel.dart';

import '../../../../../helper/helper.dart';
import '../../medicine/medicine_unit.dart';
import '../../../../../shared/network/endPoints/endPint.dart';

class MedicineServices {
  Future<List<MedicineUnit>> getMedicineUnits() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/medicine/units');
    List<MedicineUnit> unitList = [];
    for (int i = 0; i < data.length; i++) {
      unitList.add(
        MedicineUnit.fromJson(data[i]),
      );
    }
    return unitList;
  }

  Future<List<ClothingSize>> getClothesSize() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/sizes');
    List<ClothingSize> clothesSize = [];
    for (int i = 0; i < data.length; i++) {
      clothesSize.add(
        ClothingSize.fromJson(data[i]),
      );
    }
    return clothesSize;
  }

  Future<List<ClothingCategory>> getClothesCategory() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/clothing/categories');
    List<ClothingCategory> clothesCategory = [];
    for (int i = 0; i < data.length; i++) {
      clothesCategory.add(
        ClothingCategory.fromJson(data[i]),
      );
    }
    return clothesCategory;
  }

  Future<List<ClothingType>> getClothesType() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/clothing/types');
    List<ClothingType> clothesType = [];
    for (int i = 0; i < data.length; i++) {
      clothesType.add(
        ClothingType.fromJson(data[i]),
      );
    }
    return clothesType;
  }

  Future<List<MedicineModel>> getListMedicineName() async {
    List<dynamic> data =
        await Api().get(url: 'http://64.225.6.213:8085/api/v1/medicines');
    List<MedicineModel> listMedicine = [];
    for (int i = 0; i < data.length; i++) {
      listMedicine.add(MedicineModel.fromJson(data[i]));
    }

    print(data);
    print(listMedicine);
    return listMedicine;
  }
}
