import 'package:hayat_eg/features/data/datasource/need/book/book_need_datasource.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';

class BookNeedRepository {
  final BookNeedDataSource bookNeedDataSource;

  BookNeedRepository({
    required this.bookNeedDataSource,
  });

  Future<List<BookNeedResponse>?> search(String query) async {
    return await bookNeedDataSource.search(query);
  }
}
