import 'dart:convert';

import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart'as http;

import '../../../helper/helper.dart';
import '../../../models/Medicine/medicineModel.dart';
class SearchMedicineName {

  Future getMedicineName({required String medicineName})async{
    var listSearch=[];
    Uri url=Uri.parse('$baseUrl/api/v1/donations/medicine/search?q=$medicineName');
   http.Response response= await http.get(url);
   Map<String,dynamic> data=jsonDecode(response.body);
   for(int i =0 ; i< data.length; i++){
     listSearch.add(data[i]);
   }
   print(data);
  }



  
}