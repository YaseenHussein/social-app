import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';
import 'package:social_app/shared/componts.dart/constants.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../AppCubit/app_cubit.dart';
import '../AppCubit/app_states.dart';
import '../modules/post/news_post.dart';
import '../shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  bool isFormLogin = false;
  HomeLayout(this.isFormLogin, {super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      uId = CacheHelper.getData(key: "uId");
      AppCubit().get(context).isFromLogin(isFormLogin);
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AppChangePostNavBar) {
            navigatorTo(context, NewsPost());
          }
        },
        builder: (context, state) {
          var cubit = AppCubit().get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Notification),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Search),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              items: cubit.listNavBar,
            ),
          );
        },
      );
    });
  }
}
