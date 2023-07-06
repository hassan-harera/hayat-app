import 'package:flutter/foundation.dart';
import 'package:hayat_eg/features/data/datasource/need/blood/book_need_datasource.dart';
import 'package:hayat_eg/features/data/model/need/blood/blood_need_request.dart';
import 'package:hayat_eg/features/data/model/need/blood/blood_need_response.dart';

class BloodNeedRepository {
  final BloodNeedDataSource bloodNeedDataSource;

  BloodNeedRepository({
    required this.bloodNeedDataSource,
  });

  Future<BloodNeedResponse?> create(BloodNeedRequest request) async {
    return await bloodNeedDataSource.create(request);
  }

  Future<BloodNeedResponse?> updateImage(String id, Uint8List image) async {
    return await bloodNeedDataSource.updateImage(id, image);
  }

  Future<BloodNeedResponse?> upvote(int id) async {
    return await bloodNeedDataSource.upvote(id);
  }

  Future<BloodNeedResponse?> downVote(int id) async {
    return await bloodNeedDataSource.downvote(id);
  }

  Future<List<BloodNeedResponse>?> search(String query) async {
    return await bloodNeedDataSource.search(query);
  }

  Future<BloodNeedResponse?> get(String id) async {
    return bloodNeedDataSource.get(id);
  }
}
