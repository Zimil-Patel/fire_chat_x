import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blueAccent,
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.varelaRound(
        textStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      displayMedium: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.black87),
      ),
      bodyLarge: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.black),
      ),
      bodyMedium: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.black54),
      ),
      labelLarge: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blueAccent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.black54,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
    ).copyWith(
      background: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    hintColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey[800],
    textTheme: TextTheme(
      displayLarge: GoogleFonts.varelaRound(
        textStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      displayMedium: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.white70),
      ),
      bodyLarge: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.white),
      ),
      bodyMedium: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.white70),
      ),
      labelLarge: GoogleFonts.varelaRound(
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueGrey,
      textTheme: ButtonTextTheme.primary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.white70,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
    ),
    colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark, primarySwatch: Colors.blue)
        .copyWith(
      background: Colors.black,
    ),
  );
}
