import 'package:flutter/foundation.dart';
import 'package:hayat_eg/features/data/datasource/need/book/book_need_datasource.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_request.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';

class BookNeedRepository {
  final BookNeedDataSource bookNeedDataSource;

  BookNeedRepository({
    required this.bookNeedDataSource,
  });

  Future<BookNeedResponse?> create(BookNeedRequest request) async {
    return await bookNeedDataSource.create(request);
  }

  Future<BookNeedResponse?> updateImage(String id, Uint8List image) async {
    return await bookNeedDataSource.updateImage(id, image);
  }

  Future<BookNeedResponse?> upvote(int id) async {
    return await bookNeedDataSource.upvote(id);
  }

  Future<BookNeedResponse?> downVote(int id) async {
    return await bookNeedDataSource.downvote(id);
  }

  Future<List<BookNeedResponse>?> search(String query) async {
    return await bookNeedDataSource.search(query);
  }

  Future<BookNeedResponse?> get(String id) async {
    return bookNeedDataSource.get(id);
  }
}
