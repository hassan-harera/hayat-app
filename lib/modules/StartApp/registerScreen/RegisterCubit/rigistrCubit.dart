import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/modules/StartApp/registerScreen/RegisterCubit/registerState.dart';

import '../../../../shared/network/endPoints/endPint.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super((RegisterInitialState()));

  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_outlined;
  bool obscure1 = true;
  bool obscure2 = true;

  void changeObscure1() {
    obscure1 = !obscure1;
    suffixIcon =
        obscure1 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeObscureState());
  }

  void changeObscure2() {
    obscure2 = !obscure2;
    suffixIcon =
        obscure2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeObscureState());
  }

  bool checked = false;

  void changeCheckbox(value) {
    checked = value;
    print(checked);
    emit(RegisterChangeCheckboxState());
  }

  void registerReWithApi({
    required String mobile,
    required String password,
    required String firstName,
    required String lastName,
    required String otp,
  }) async {
    emit(RegisterLoadingState());
    http.Response response =
        await http.post(Uri.parse('$baseUrl/api/v1/auth/signup'),
            body: jsonEncode({
              "mobile": mobile,
              "first_name": firstName,
              "last_name": lastName,
              "password": password,
              "otp": otp
            }),
            headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'language': 'ar',
          'User-Agent': 'PostmanRuntime/7.32.2',
        });
    var responseBode = jsonDecode(response.body);
    if (responseBode['status'] == 'UNSUPPORTED_MEDIA_TYPE' ||
        responseBode['status'] == 'BAD_REQUEST' ||
        responseBode['status'] == 'CONFLICT') {
      emit(RegisterErrorState(responseBode['message']));
    } else {
      emit(RegisterSuccessState());
    }
  }

  void phoneVerification({
    required String mobile,
  }) async {
    // emit(SetPhoneLoadingState());
    http.Response response =
        await http.post(Uri.parse('$baseUrl/api/v1/otp/request?mobile=$mobile'),
            body: jsonEncode({
              "mobile": mobile,
            }),
            headers: {
          'Content-Type': 'application/json',
        });
    if (response.body.isNotEmpty) {
      json.decode(response.body);
    }
    emit(PhoneVerificationRegisterSuccessState());
    // if (responseBode['status'] == 'UNSUPPORTED_MEDIA_TYPE' ||
    //     responseBode['status'] == 'BAD_REQUEST' ||
    //     responseBode['status'] == 'CONFLICT'
    //
    // ) {
    //   emit(SetPhoneErrorState(responseBode['message']));
    // } else {
    //   emit(SetPhoneSuccessState());
    // }
  }

  void oTPVerificationRegister({
    required String mobile,
    required String otp,
  }) async {
    // emit(OtpVerificationLoadingState());
    http.Response response = await http
        .post(Uri.parse('$baseUrl/api/v1/otp/validate?mobile=$mobile&otp=$otp'),
            body: jsonEncode({
              "mobile": mobile,
              "otp": otp,
            }),
            headers: {
          'Content-Type': 'application/json',
        });
    // var responseBode = json.decode(response.body);
    if (response.body.isNotEmpty) {
      json.decode(response.body);
    }
    emit(OTPVerificationRegisterSuccessState());
    // if (responseBode['status'] == 'UNSUPPORTED_MEDIA_TYPE' ||
    //     responseBode['status'] == 'BAD_REQUEST' ||
    //     responseBode['status'] == 'CONFLICT'
    // ) {
    //   emit(OtpVerificationErrorState(responseBode['message']));
    // }
    // else if (responseBode == null) {
    //   emit(OtpVerificationSuccessState());
    // }
    // else {
    //   emit(OtpVerificationSuccessState());
    // }
  }
}
