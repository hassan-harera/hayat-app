import 'api_error.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class BadRequestException implements Exception {
  final ApiError apiError;

  BadRequestException({
    required this.apiError,
  });
}
