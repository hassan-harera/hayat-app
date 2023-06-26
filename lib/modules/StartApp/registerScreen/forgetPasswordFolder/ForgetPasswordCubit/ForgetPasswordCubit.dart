import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/modules/StartApp/registerScreen/RegisterCubit/registerState.dart';

import 'forgetPasswordState.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super((ForgetPasswordInitialState()));

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);


  IconData suffixIcon = Icons.visibility_outlined;
  bool obscure1 = true;
  bool obscure2 = true;

  void changeObscure1() {
    obscure1 = !obscure1;

    suffixIcon =
    obscure1 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ForgetPasswordChangeObscureState());
  }

  void changeObscure2() {
    obscure2 = !obscure2;
    suffixIcon =
    obscure2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ForgetPasswordChangeObscureState());
  }


  bool checked = false;

  void changeCheckbox(value) {
    checked = value;
    print(checked);
    emit(ForgetPasswordChangeCheckboxState());
  }

  void forgetPasswordWithApi({
    required String mobile,
    required String newPassword,
    required String otp,


  }) async {
    emit(ForgetPasswordLoadingState());
    http.Response response = await http.post(
        Uri.parse('http://64.225.6.213:8080/api/v1/auth/password-reset'),
        body: jsonEncode({
          "mobile": mobile,
          "password": newPassword,
          "otp": otp
        }),
        headers: {
          'Content-Type': 'application/json',
        }
    );

      var body = json.decode(response.body);

    if (body['status'] == 'UNSUPPORTED_MEDIA_TYPE' ||
        body['status'] == 'BAD_REQUEST' ||
        body['status'] == 'CONFLICT'

    ) {
      emit(ForgetPasswordErrorState(body['message']));
    } else if(body==null) {
      emit(ForgetPasswordSuccessState());
    }
  }


  void sendMobileNumber({
    required String mobile,

  }) async {
    // emit(SetPhoneLoadingState());
    http.Response response = await http.post(
        Uri.parse('http://64.225.6.213:8080/api/v1/otp/request?mobile=$mobile'),
        body: jsonEncode({
          "mobile": mobile,

        }),
        headers: {
          'Content-Type': 'application/json',
        }
    );
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
    emit(SetPhoneSuccessState());
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


  void sendMobileAndOTPNumber({
    required String mobile,
    required String otp,

  }) async {
    // emit(OtpVerificationLoadingState());
    http.Response response = await http.post(
        Uri.parse(
            'http://64.225.6.213:8080/api/v1/otp/validate?mobile=$mobile&otp=$otp'),
        body: jsonEncode({
          "mobile": mobile,
          "otp": otp,

        }),
        headers: {
          'Content-Type': 'application/json',
        }
    );
    // var responseBode = json.decode(response.body);
    if (response.body.isNotEmpty) {
      json.decode(response.body);
    }
    emit(OtpVerificationSuccessState());
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


