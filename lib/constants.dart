import 'package:flutter/material.dart';

// most frequently used colors in the app
const Color primaryColor = Color(0xff67a0f1);
const Color secondaryColor = Color(0xffb1d1f8);
const Color whiteColor = Color(0xffdcedfe);

// light and dark theme
const Color primaryDarkColor = Color(0xff17171f);
const Color secondaryDarkColor = Color(0xff2c2c36);
ThemeData lightTheme = ThemeData(
  fontFamily: 'Lemonada',
  primarySwatch: Colors.blueGrey,
  backgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: primaryColor,
    unselectedItemColor: whiteColor,
    selectedLabelStyle: TextStyle(letterSpacing: 0, fontSize: 13, fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0, color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
);
ThemeData darkTheme = ThemeData(
  fontFamily: 'Lemonada',
  primarySwatch: Colors.orange,
  backgroundColor: primaryDarkColor,
  appBarTheme: const AppBarTheme(backgroundColor: primaryDarkColor, elevation: 0),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryDarkColor,
    elevation: 0,
    selectedItemColor: primaryColor,
    unselectedItemColor: whiteColor,
    selectedLabelStyle: TextStyle(letterSpacing: 0, fontWeight: FontWeight.w500, color: primaryColor),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  ),
  textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0, color: Colors.white),),
  scaffoldBackgroundColor: primaryDarkColor,
);

// sharedPreferences Keys
const String onBoarding = 'onBoarding';
const String onToken = 'onToken';
const String isDark = 'isDark';

// endpoints section
const String endpointLogin = 'login';
const String endpointRegister = 'register';
const String endpointHome = 'home';
const String endpointCategory = 'categories';
const String endpointFavourite = 'favorites';
const String endpointProfile = 'profile';
const String endpointLogout = 'logout';
const String endpointUpdateProfile = 'update-profile';
const String endpointSearch = 'products/search';

// my token
String? token = '';