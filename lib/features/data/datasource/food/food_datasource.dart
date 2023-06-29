import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/helper/helper.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';

class FoodDataSource {
  Future<List<FoodCategory>> listFoodCategories() async {
    List<dynamic> data =
        await Api().get(url: '$baseUrl/api/v1/food/categories');
    return List<FoodCategory>.from(data.map((e) => FoodCategory.fromJson(e)));
  }

  Future<List<FoodUnit>> listFoodUnits() async {
    List<dynamic> data = await Api().get(url: '$baseUrl/api/v1/food/units');
    return List<FoodUnit>.from(data.map((e) => FoodUnit.fromJson(e)));
  }
}
