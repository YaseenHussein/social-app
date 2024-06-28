import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/call/call_page.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/modules/onBoradring/on_boarding.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';
import 'package:social_app/shared/componts.dart/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/style/thems.dart';

import 'AppCubit/app_cubit.dart';
import 'firebase_options.dart';
import 'AppCubit/observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showTost(msg: " on background Message", state: TostState.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
////////////////////////////
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');

  ///
  var token = await FirebaseMessaging.instance.getToken();
  print(token.toString());
  //foreground FCM
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showTost(msg: "on Message", state: TostState.SUCCESS);
  }); //استقبال الاشعارات عند الفتح اي استقبل الاشعارات كامل عند الفتح
//عند الضغط على الاشعار والدخول على التطبيق
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showTost(msg: "when App Close", state: TostState.SUCCESS);
  });
  //background FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
///////////////////////////////
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.intil();
  uId = CacheHelper.getData(key: "uId");
  bool? onBoradingOpen = CacheHelper.getData(key: "onBoarding");
  print(uId);
  if (onBoradingOpen != null) {
    if (uId != null) {
      runApp(MyApp(HomeLayout(false)));
    } else {
      runApp(MyApp(const LoginScreen()));
    }
  } else {
    runApp(MyApp(const OnBorading()));
  }
}

class MyApp extends StatelessWidget {
  var startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getPostData()
        ..getAllUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThem,
        darkTheme: darkThem,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
