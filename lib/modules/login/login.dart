import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/componts.dart/componnts.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showTost(msg: state.error, state: TostState.ERROR);
          } else if (state is LoginSuccussState) {
            CacheHelper.putData(key: 'uId', value: state.uId).then((value) {
              showTost(msg: "نجح عمليت تسجيل الدخول", state: TostState.SUCCESS);
              navigatorFinish(context, HomeLayout(true));

            });
          }
        },
        builder: (context, state) {
          var cubitLogin = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),//Login Text
                        const SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            controller: controllerEmail,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "You should Enter Your Email address";
                              }
                              return null;
                            },
                            label: 'Email',
                            preFixIcon: Icons.email),
                        const SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                          onSubmitted: (p0) {//whan enter enter button on keboard will send the data to the cubit to add it
                            if (formKey.currentState!.validate()) {
                              cubitLogin.userLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                            }
                          },
                          obscureText: cubitLogin.isPassword,
                          textInputType: TextInputType.visiblePassword,
                          controller: controllerPassword,
                          sufFixIconPress: () {
                            cubitLogin.changeSuffixIcon();
                          },
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "Password is Too Short";
                            }
                            return null;
                          },
                          label: 'Password',
                          preFixIcon: Icons.lock,
                          sufFixIcon: cubitLogin.suffixIcon,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultMartialButton(
                            btnOnPress: () {
                              if (formKey.currentState!.validate()) {
                                cubitLogin.userLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text,
                                );
                              }
                            },
                            label: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have an account",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            defaultTextButton(
                                onPress: () {
                                  navigatorTo(context, RegisterScreen());
                                },
                                label: "register")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
