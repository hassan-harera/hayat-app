import 'dart:ffi';
import 'dart:typed_data';

import 'package:hayat_eg/features/data/datasource/donation/medicine/medicine_donation_datasource.dart';
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

  Future<MedicineDonationResponse?> get(int id) async {
    return await medicineDonationDataSource.get(id);
  }

  Future<MedicineDonationResponse?> upvote(int id) async {
    return await medicineDonationDataSource.upvote(id);
  }

  Future<MedicineDonationResponse?> downvote(int id) async {
    return await medicineDonationDataSource.downvote(id);
  }

  Future<MedicineDonationResponse?> updateImage(int id, Uint8List image) async {
    return await medicineDonationDataSource.updateImage(id, image);
  }
}
