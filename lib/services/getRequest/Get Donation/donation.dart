import '../../../helper/helper.dart';
import '../../../models/Clothes/clothesType.dart';
import '../../../shared/network/endPoints/endPint.dart';

class GetAllDonation {
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
}
