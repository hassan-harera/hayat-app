import '../../../../models/LoginModel/loginModel.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginChangeObscureState extends LoginStates{}
class LoginToRegisterState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{

}
class LoginErrorState extends LoginStates
{
final  String error;
  LoginErrorState(this.error);
}


class LoginSearchLoadingState extends LoginStates{}
class LoginSearchSuccessState extends LoginStates{

}
class LoginSearchErrorState extends LoginStates
{
  final  String error;
  LoginSearchErrorState(this.error);
}