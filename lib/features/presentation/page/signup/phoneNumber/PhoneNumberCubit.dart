import 'dart:convert';
import 'package:hayat_eg/features/presentation/page/signup/phoneNumber/PhoneNumberStates.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberCubit extends Cubit<PhoneNumberStates> {
  PhoneNumberCubit() : super((PhoneNumberInitialState()));

  static PhoneNumberCubit get(context) => BlocProvider.of(context);

  void phoneVerificationInRegister({
    required String mobile,
  }) async {
    emit(PhoneNumberLoadingState());
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
    emit(PhoneNumberSuccessState());
  }
}
