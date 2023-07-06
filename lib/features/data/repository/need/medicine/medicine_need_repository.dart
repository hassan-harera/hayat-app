import 'dart:ffi';
import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/need/medicine/medicine_need_datasource.dart';
import 'package:hayat_eg/features/data/model/need/medicine/medicine_need_request.dart';
import 'package:hayat_eg/features/data/model/need/medicine/medicine_need_response.dart';

class MedicineNeedRepository {
  final MedicineNeedDataSource medicineNeedDataSource;

  MedicineNeedRepository({
    required this.medicineNeedDataSource,
  });

  Future<MedicineNeedResponse?> create(
      MedicineNeedRequest request) async {
    return await medicineNeedDataSource.create(request);
  }

  Future<List<MedicineNeedResponse>?> search(String query) async {
    return await medicineNeedDataSource.search(query);
  }

  Future<MedicineNeedResponse?> get(int id) async {
    return await medicineNeedDataSource.get(id);
  }

  Future<MedicineNeedResponse?> upvote(int id) async {
    return await medicineNeedDataSource.upvote(id);
  }

  Future<MedicineNeedResponse?> downvote(int id) async {
    return await medicineNeedDataSource.downvote(id);
  }

  Future<MedicineNeedResponse?> updateImage(int id, Uint8List image) async {
    return await medicineNeedDataSource.updateImage(id, image);
  }
}
