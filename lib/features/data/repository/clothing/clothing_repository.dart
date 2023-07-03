import 'package:hayat_eg/features/data/datasource/clothing/clothing_datasource.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_condition.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_seasson.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';

class ClothingRepository {
  final ClothingDatasource clothingDataSource;

  ClothingRepository({
    required this.clothingDataSource,
  });

  Future<List<ClothingSize>> listClothingSizes() {
    return clothingDataSource.listClothingSizes();
  }

  Future<List<ClothingCategory>> listClothingCategories() async {
    return await clothingDataSource.listClothingCategories();
  }

  Future<List<ClothingType>> listClothingTypes() async {
    return await clothingDataSource.listClothingTypes();
  }

  Future<List<ClothingCondition>> listClothingCondition() async {
    return await clothingDataSource.listClothingCondition();
  }

  Future<List<ClothingSeason>> listClothingSeason() async {
    return await clothingDataSource.listClothingSeason();
  }
}
