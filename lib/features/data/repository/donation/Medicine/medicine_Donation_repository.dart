import 'package:hayat_eg/features/data/datasource/donation/medicine/medicine_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';



class MedicineRepository {
  final MedicineDonationDataSource medicineDonationDataSource;

  MedicineRepository({
    required this.medicineDonationDataSource,
  });

  Future<MedicineDonationResponse?> create(
      MedicineDonationRequest request) async {
    return await medicineDonationDataSource.create(request);
  }

  Future<List<Medicine>?> search(String query) async {
    return await medicineDonationDataSource.search(query);
  }
}
