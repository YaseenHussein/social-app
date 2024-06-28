abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccussState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterCreateUserLoadState extends RegisterStates {}

class RegisterCreateUserSuccussState extends RegisterStates {
  String uId;
  RegisterCreateUserSuccussState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterStates {
  final String error;

  RegisterCreateUserErrorState(this.error);
}

class RegisterChangePasswordSuffixIcon extends RegisterStates {}
