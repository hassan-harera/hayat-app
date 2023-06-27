// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/datasource/city_datasource.dart';
import 'features/data/datasource/medicine_donation_datasource.dart';
import 'features/data/repository/CityRepository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc

  // Use cases

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepository(cityDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CityDataSource>(
    () => CityDataSource(client: sl()),
  );

  sl.registerLazySingleton<MedicineDonationDataSource>(
    () => MedicineDonationDataSource(client: sl()),
  );

  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
