import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';

// Light Mode
ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(),
  scaffoldBackgroundColor: scaffoldLightColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: scaffoldLightColor,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  primaryColor: backgroundLightColor,
  cardColor: cardLightColor,
  canvasColor: btnNavIconLightColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: btnNavIconLightColor,
    backgroundColor: scaffoldLightColor,
  ),
);

// Dark Mode
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: scaffoldDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: scaffoldDarkColor,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primaryColor: backgroundDarkColor,
  cardColor: cardDarkColor,
  canvasColor: cardDarkColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: btnNavIconDarkColor,
    backgroundColor: scaffoldDarkColor,
  ),
);
