import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white ,
  appBarTheme:  const AppBarTheme(
      titleSpacing: 14,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 20
      )
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,

  ),
  fontFamily: 'lato',
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black
      )
  ),
);
ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739') ,
  appBarTheme:   AppBarTheme(
      titleSpacing: 14,
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 20
      )
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey
  ),
  fontFamily: 'lato',
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white
      )
  ),
);