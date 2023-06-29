import 'package:flutter/cupertino.dart';
import 'package:hayat_eg/features/data/model/medicine_donation.dart';

import '../../../../../helper/helper.dart';

class updateMedicine {
  Future<MedicineDonation> postMedicineDonation({
    required String communication_method,
    required String quantity,
    required String city_id,
    required String description,
    required String state,
    required String title,
    required String medicine_unit_id,
    required String medicine_id,
    required String medicine_expiration_date,
    @required String? token,
  }) async {
    Map<String, dynamic> data = await Api().post(
      url: 'http://64.225.6.213:8080/api/v1/donations/medicine',
      body: {
        'quantity': quantity,
        'city_id': city_id,
        'communication_method': communication_method,
        'description': description,
        'state': state,
        'title': title,
        'medicine_unit_id': medicine_unit_id,
        'medicine_id': medicine_id,
        'medicine_expiration_date': medicine_expiration_date,
      },
      token: token,
    );

    return MedicineDonation.fromJson(data);
  }
}
