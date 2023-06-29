// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/donations_datasource.dart';
import 'package:hayat_eg/features/data/repository/donation/book_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
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
  sl.registerLazySingleton<DonationRepository>(
    () => DonationRepository(donationDataSource: sl()),
  );
  sl.registerLazySingleton<BookDonationRepository>(
    () => BookDonationRepository(bookDonationDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CityDataSource>(
    () => CityDataSource(client: sl()),
  );
  sl.registerLazySingleton<DonationDataSource>(
    () => DonationDataSource(client: sl()),
  );
  sl.registerLazySingleton<BookDonationDataSource>(
    () => BookDonationDataSource(client: sl()),
  );

  sl.registerLazySingleton<MedicineDonationDataSource>(
    () => MedicineDonationDataSource(client: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
