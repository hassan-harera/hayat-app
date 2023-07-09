// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hayat_eg/features/data/datasource/clothing/clothing_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/clothing/clothing_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/donations_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/food/food_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/food/food_datasource.dart';
import 'package:hayat_eg/features/data/datasource/medicine/medicine_datasource.dart';
import 'package:hayat_eg/features/data/datasource/need/blood/book_need_datasource.dart';
import 'package:hayat_eg/features/data/datasource/need/book/book_need_datasource.dart';
import 'package:hayat_eg/features/data/datasource/need/need_datasource.dart';
import 'package:hayat_eg/features/data/datasource/profile/profile_datasource.dart';
import 'package:hayat_eg/features/data/repository/clothing/clothing_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/book/book_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/food/food_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/medicine/medicine_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/food/food_repository.dart';
import 'package:hayat_eg/features/data/repository/medicine/medicine_repository.dart';
import 'package:hayat_eg/features/data/repository/need/blood/blood_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/book/book_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/medicine/medicine_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/datasource/city_datasource.dart';
import 'features/data/datasource/donation/medicine/medicine_donation_datasource.dart';
import 'features/data/datasource/need/medicine/medicine_need_datasource.dart';
import 'features/data/repository/CityRepository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc

  // Use cases

  /**
   * Donation Repositories
   */
  sl.registerLazySingleton<CityRepository>(
    () => CityRepository(cityDataSource: sl()),
  );
  sl.registerLazySingleton<DonationRepository>(
    () => DonationRepository(donationDataSource: sl()),
  );
  sl.registerLazySingleton<BookDonationRepository>(
    () => BookDonationRepository(bookDonationDataSource: sl()),
  );
  sl.registerLazySingleton<FoodDonationRepository>(
    () => FoodDonationRepository(foodDonationDataSource: sl()),
  );
  sl.registerLazySingleton<ClothingDonationRepository>(
    () => ClothingDonationRepository(clothingDonationDataSource: sl()),
  );
  sl.registerLazySingleton<MedicineDonationRepository>(
    () => MedicineDonationRepository(medicineDonationDataSource: sl()),
  );

  /**
   * Need Repositories
   */
  sl.registerLazySingleton<NeedRepository>(
    () => NeedRepository(needDataSource: sl()),
  );
  sl.registerLazySingleton<BookNeedRepository>(
    () => BookNeedRepository(bookNeedDataSource: sl()),
  );
  sl.registerLazySingleton<MedicineNeedRepository>(
    () => MedicineNeedRepository(medicineNeedDataSource: sl()),
  );
  sl.registerLazySingleton<BloodNeedRepository>(
    () => BloodNeedRepository(bloodNeedDataSource: sl()),
  );

  /**
   * Facets Repositories
   */
  sl.registerLazySingleton<FoodRepository>(
    () => FoodRepository(foodDatasource: sl()),
  );
  sl.registerLazySingleton<ClothingRepository>(
    () => ClothingRepository(clothingDataSource: sl()),
  );
  sl.registerLazySingleton<MedicineRepository>(
    () => MedicineRepository(sl()),
  );

  /**
   * Donation Data Sources
   */
  sl.registerLazySingleton<DonationDataSource>(
    () => DonationDataSource(client: sl()),
  );
  sl.registerLazySingleton<BookDonationDataSource>(
    () => BookDonationDataSource(sl()),
  );
  sl.registerLazySingleton<MedicineDonationDataSource>(
    () => MedicineDonationDataSource(client: sl()),
  );
  sl.registerLazySingleton<FoodDonationDataSource>(
    () => FoodDonationDataSource(sl()),
  );
  sl.registerLazySingleton<ClothingDonationDataSource>(
    () => ClothingDonationDataSource(sl()),
  );

  /**
   * Facets Data Sources
   */
  sl.registerLazySingleton<CityDataSource>(
    () => CityDataSource(client: sl()),
  );
  sl.registerLazySingleton<FoodDataSource>(
    () => FoodDataSource(client: sl()),
  );
  sl.registerLazySingleton<ClothingDatasource>(
    () => ClothingDatasource(sl()),
  );
  sl.registerLazySingleton<MedicineDataSource>(
    () => MedicineDataSource(sl()),
  );
  sl.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSource(client: sl()),
  );

  /**
   * Need Data Sources
   */
  sl.registerLazySingleton<NeedDataSource>(
    () => NeedDataSource(client: sl()),
  );
  sl.registerLazySingleton<BookNeedDataSource>(
    () => BookNeedDataSource(sl()),
  );
  sl.registerLazySingleton<MedicineNeedDataSource>(
    () => MedicineNeedDataSource(client: sl()),
  );
  sl.registerLazySingleton<BloodNeedDataSource>(
    () => BloodNeedDataSource(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
