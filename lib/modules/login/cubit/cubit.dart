import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  //late LoginModels loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccussState(value.user!.uid.toString()));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.remove_red_eye;
  bool isPassword = true;
  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(LoginChangePasswordSuffixIcon());
  }
}
