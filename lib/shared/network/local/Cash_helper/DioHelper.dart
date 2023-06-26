import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper{

  static late  Dio dio ;
  static init(){
    dio=Dio(
        BaseOptions(
            baseUrl: 'http://64.225.6.213:8080',
            // receiveDataWhenStatusError: true,
headers: {
              'Content-Type':'application/json',

}
        )
    );
  }
  static Future<Response>  getData(
      {
        required String url,
        Map<String,dynamic> ?query,
        String langaunge='ar',
        String? token,
      }
      )async{
    dio.options.headers={

     'Authorization': token,
  'Content-Type': 'application/json',
    };


    return await dio.get(url , queryParameters: query );
  }
  static Future<Response> postData ({
    required String url,
   // String langaunge='ar',
   //  String? token,
     Map<String,dynamic>? query,
   required  Map<String,dynamic> data,
})async{
    dio.options.headers={
    //   'lang':langaunge,
    // 'Authorization': token,
    //   'Content-Type': 'application/json',
    };
    return dio.post(url,
    queryParameters: query,
      data: data,
    );
  }
}