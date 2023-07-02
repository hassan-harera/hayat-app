import 'package:hayat_eg/features/data/datasource/need/book/book_need_datasource.dart';
import 'package:hayat_eg/features/data/datasource/need/medicine/medicine_need_datasource.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/features/data/model/need/medicine/medicine_need_response.dart';

class MedicineNeedRepository {
  final MedicineNeedDataSource medicineNeedDataSource;

  MedicineNeedRepository({
    required this.medicineNeedDataSource,
  });

  Future<List<MedicineNeedResponse>?> search(String query) async {
    return await medicineNeedDataSource.search(query);
  }
}
