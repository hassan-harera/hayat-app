import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightThem = ThemeData(
  // fontFamily: 'assets/Fonts/PTSans-Regular.ttf',
  scaffoldBackgroundColor: const Color(0xffF1F4F8),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.amber,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),

  primarySwatch: defultColor,
  iconTheme: const IconThemeData(
    color: Colors.amber,
  ),
  appBarTheme: AppBarTheme(
    color: const Color(0xffF1F4F8),
    titleSpacing: 20,
    iconTheme: IconThemeData(color: defultColor),

    elevation: 0,

    // backwardsCompatibility: false,
    titleTextStyle: const TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  ),
);
ThemeData darkThem = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    )),
    primarySwatch: defultColor,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleSpacing: 20,
        elevation: 0,
        backgroundColor: Color(0xFF333739),
        // backwardsCompatibility: false,

        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF333739),
    ),
    scaffoldBackgroundColor: const Color(0xffF1F4F8));
