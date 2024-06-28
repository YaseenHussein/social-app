import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required bool isEmailVerified,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid.toString(),
        isEmailVerified: isEmailVerified,
      );
    }).catchError((error) async {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required bool isEmailVerified,
  }) {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image:
          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1687521990~exp=1687522590~hmac=dcd9d0c096b9314315db2985b0e67562be6864e62b63adca56348eb6ae4ed7c7',
      bio: "write your bio ...",
      cover:
          'https://simpsonscreative.co.uk/wp-content/uploads/2022/01/2022-Dimensions.jpg',
      isEmailVerified: isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccussState(uId));
    }).catchError((error) {
      print(error.toString());
      print(error());
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.remove_red_eye;
  bool isPassword = true;
  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(RegisterChangePasswordSuffixIcon());
  }
}
