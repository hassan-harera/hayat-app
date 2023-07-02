abstract class PhoneNumberStates {}

class PhoneNumberInitialState extends PhoneNumberStates {}

class PhoneNumberLoadingState extends PhoneNumberStates {}

class PhoneNumberSuccessState extends PhoneNumberStates {}

class PhoneNumberErrorState extends PhoneNumberStates {
  final String errorMessage;

  PhoneNumberErrorState(this.errorMessage);
}

class PhoneNumberOtpVerificationLoadingState extends PhoneNumberStates {}

class PhoneNumberOtpVerificationSuccessState extends PhoneNumberStates {}

class PhoneNumberOtpVerificationErrorState extends PhoneNumberStates {
  final String errorMessage;

  PhoneNumberOtpVerificationErrorState(this.errorMessage);
}
