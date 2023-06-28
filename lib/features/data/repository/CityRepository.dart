import '../datasource/city_datasource.dart';
import '../model/city/city.dart';

class CityRepository {
  final CityDataSource cityDataSource;

  CityRepository({
    required this.cityDataSource,
  });

  Future<List<City>?> search(String query) async {
    return await cityDataSource.search(query);
  }
}
