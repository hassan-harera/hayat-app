import 'package:hayat_eg/features/data/model/food/foodCategory.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';

class FoodServices {
  Future<List<FoodUnit>> getFoodUnits() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/food/units');
    List<FoodUnit> unitList = [];
    for (int i = 0; i < data.length; i++) {
      unitList.add(
        FoodUnit.fromJson(data[i]),
      );
    }
    return unitList;
  }

  Future<List<FoodCategory>> getFoodCategory() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/food/categories');
    List<FoodCategory> categoryList = [];
    for (int i = 0; i < data.length; i++) {
      categoryList.add(
        FoodCategory.fromJson(data[i]),
      );
    }
    return categoryList;
  }
}
