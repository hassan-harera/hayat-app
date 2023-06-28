abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterChangeObscureState extends RegisterState {}

class RegisterChangeCheckboxState extends RegisterState {}

class RegisterToRegisterState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String errorMessage;

  RegisterErrorState(this.errorMessage);
}

class PhoneVerificationRegisterLoadingState extends RegisterState {}

class PhoneVerificationRegisterSuccessState extends RegisterState {}

class PhoneVerificationRegisterErrorState extends RegisterState {
  final String errorMessage;

  PhoneVerificationRegisterErrorState(this.errorMessage);
}

class OTPVerificationRegisterLoadingState extends RegisterState {}

class OTPVerificationRegisterSuccessState extends RegisterState {}

class OTPVerificationRegisterErrorState extends RegisterState {
  final String errorMessage;

  OTPVerificationRegisterErrorState(this.errorMessage);
}
