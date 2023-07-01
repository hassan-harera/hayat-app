import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/food/food_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/need/need_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_response.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';

class NeedRepository {
  final NeedDataSource needDataSource;

  NeedRepository({
    required this.needDataSource,
  });

  Future<List<NeedResponse>?> search(String query) async {
    return await needDataSource.search(query);
  }
}
