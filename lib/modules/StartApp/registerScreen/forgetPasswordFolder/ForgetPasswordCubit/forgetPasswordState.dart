abstract class ForgetPasswordStates{}
class ForgetPasswordInitialState extends ForgetPasswordStates{}
class ForgetPasswordChangeObscureState extends ForgetPasswordStates{}
class ForgetPasswordChangeCheckboxState extends ForgetPasswordStates{}
//class ForgetPasswordToForgetPasswordState extends ForgetPasswordStates{}
class ForgetPasswordLoadingState extends ForgetPasswordStates{}
class ForgetPasswordSuccessState extends ForgetPasswordStates{
}
class ForgetPasswordErrorState extends ForgetPasswordStates
{
   final String errorMessage;
  ForgetPasswordErrorState(this.errorMessage);
}


class SetPhoneLoadingState extends ForgetPasswordStates{}
class SetPhoneSuccessState extends ForgetPasswordStates{
}
class SetPhoneErrorState extends ForgetPasswordStates
{
  final String errorMessage;
  SetPhoneErrorState(this.errorMessage);
}




class OtpVerificationLoadingState extends ForgetPasswordStates{}
class OtpVerificationSuccessState extends ForgetPasswordStates{
}
class OtpVerificationErrorState extends ForgetPasswordStates
{
  final String errorMessage;
  OtpVerificationErrorState(this.errorMessage);
}