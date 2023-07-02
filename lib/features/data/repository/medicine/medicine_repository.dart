import 'package:hayat_eg/features/data/datasource/food/food_datasource.dart';
import 'package:hayat_eg/features/data/datasource/medicine/medicine_datasource.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine_unit.dart';

class MedicineRepository {
  final MedicineDataSource _medicineDatasource;

  MedicineRepository(this._medicineDatasource);

  Future<List<Medicine>> listMedicines() async {
    return await _medicineDatasource.listMedicines();
  }

  Future<List<MedicineUnit>> listUnits() async {
    return await _medicineDatasource.listMedicineUnits();
  }
}
