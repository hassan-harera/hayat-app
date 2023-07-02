import 'package:hayat_eg/core/json/json_encoder.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/network/endPoints/endPint.dart';
import '../../model/medicine/medicine_unit.dart';

class MedicineDataSource {
  final http.Client client;

  MedicineDataSource(this.client);

  Future<List<MedicineUnit>> listMedicineUnits() async {
    var response =
        await client.get(Uri.parse('$baseUrl/api/v1/medicine/units'));
    List<dynamic> data = decodeJson(response.body);
    return List<MedicineUnit>.from(data.map((e) => MedicineUnit.fromJson(e)));
  }

  Future<List<Medicine>> listMedicines() async {
    var response =
    await client.get(Uri.parse('$baseUrl/api/v1/medicines'));
    List<dynamic> data = decodeJson(response.body);
    return List<Medicine>.from(data.map((e) => Medicine.fromJson(e)));
  }
}
