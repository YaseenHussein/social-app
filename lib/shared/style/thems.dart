import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

var lightThem = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black, size: 24.0),
    actionsIconTheme: IconThemeData(color: defaultColorThem),
    titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white),
  ),
  primarySwatch: defaultColorThem,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
  ),
);
var darkThem = ThemeData(
  scaffoldBackgroundColor: HexColor('#556666'),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('#556666'),
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.white, size: 24.0),
    titleTextStyle: const TextStyle(
        fontFamily: 'Jannah',
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('#556666'),
    ),
  ),
  primarySwatch: defaultColorThem,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('#556666'),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: defaultBottomNivBar,
  ),
);
