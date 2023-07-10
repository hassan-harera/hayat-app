abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeObscureState extends LoginStates {}
class LoginObscureState extends LoginStates {}

class LoginToRegisterState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String token;

  LoginSuccessState(this.token);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginSearchLoadingState extends LoginStates {}

class LoginSearchSuccessState extends LoginStates {}

class LoginSearchErrorState extends LoginStates {
  final String error;

  LoginSearchErrorState(this.error);
}

class GoogleLoginLoadingState extends LoginStates {}

class GoogleLoginSuccessState extends LoginStates {
  final String token;

  GoogleLoginSuccessState(this.token);
}

class GoogleLoginErrorState extends LoginStates {
  final String error;

  GoogleLoginErrorState(this.error);
}
