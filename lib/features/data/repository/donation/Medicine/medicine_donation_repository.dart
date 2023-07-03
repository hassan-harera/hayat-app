import 'package:hayat_eg/features/data/datasource/donation/book/book_donation_datasource.dart';
import 'package:hayat_eg/features/data/datasource/donation/medicine/medicine_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_response.dart';

class MedicineDonationRepository {
  final MedicineDonationDataSource medicineDonationDataSource;

  MedicineDonationRepository({
    required this.medicineDonationDataSource,
  });

  Future<MedicineDonationResponse?> create(
      MedicineDonationRequest request) async {
    return await medicineDonationDataSource.create(request);
  }

  Future<List<MedicineDonationResponse>?> search(String query) async {
    return await medicineDonationDataSource.search(query);
  }
}
