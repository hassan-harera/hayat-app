import 'package:hayat_eg/features/data/datasource/food/food_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_response.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';

class FoodRepository {
  final FoodDataSource foodDatasource;

  FoodRepository({
    required this.foodDatasource,
  });

  Future<List<FoodCategory>>? listCategories() async {
    return await foodDatasource.listFoodCategories();
  }

  Future<List<FoodUnit>>? listUnits() async {
    return await foodDatasource.listFoodUnits();
  }
}
