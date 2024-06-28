abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccussState extends LoginStates {
  late String uId;
  LoginSuccussState(this.uId);
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordSuffixIcon extends LoginStates {}
