import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';

const textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 40,
    fontFamily: "CircularStd-Black",
  ),
  headlineMedium: TextStyle(
    fontSize: 30,
    fontFamily: "CircularStd-Bold",
  ),
  titleLarge: TextStyle(
    fontSize: 24,
    fontFamily: "CircularStd-Medium",
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontFamily: "CircularStd-Book",
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontFamily: "CircularStd-Book",
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontFamily: "CircularStd-Book",
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontFamily: "CircularStd-Book",
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontFamily: "CircularStd-Book",
  ),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Palette.blue,
  ),
  scaffoldBackgroundColor: Palette.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Palette.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme.light(
    primary: Palette.white,
    secondary: Palette.lightOrange,
    onPrimary: Palette.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Palette.white,
      elevation: 0,
      selectedItemColor: Palette.blue,
      selectedIconTheme: IconThemeData(
        color: Palette.blue,
      )),
  textTheme: textTheme,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Palette.blue),
      foregroundColor: WidgetStateProperty.all(Palette.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Palette.blue),
          foregroundColor: WidgetStateProperty.all(Palette.white))),
);
