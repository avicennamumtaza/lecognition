import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Color.fromARGB(255, 244, 246, 255),
        primary: Color.fromARGB(255, 255, 131, 23),
        secondary: Color.fromARGB(255, 243, 198, 35),
        onPrimary: Color.fromARGB(255, 244, 246, 255),
        onSecondary: Color.fromARGB(255, 97, 97, 97),
        onPrimaryContainer: Color.fromARGB(255, 255, 131, 23),
        onSecondaryContainer: Color.fromARGB(255, 255, 131, 23),
        onPrimaryFixed: Color.fromARGB(255, 255, 255, 255),
        inversePrimary: Color.fromARGB(255, 0, 0, 0),
        onInverseSurface: Color.fromARGB(255, 244, 244, 244),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
    ),
    cardColor: Color.fromARGB(255, 244, 246, 255),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 255, 131, 23),
        foregroundColor: Color.fromARGB(255, 244, 246, 255),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 244, 246, 255),
        selectedItemColor: Color.fromARGB(255, 255, 131, 23),
        unselectedItemColor: Color.fromARGB(255, 154, 154, 154),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 131, 23)),
            foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 244, 246, 255)),
        ),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Color.fromARGB(255, 244, 246, 255),
        contentTextStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
        ),
    ),
    indicatorColor: Color.fromARGB(255, 255, 131, 23),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromARGB(255, 243, 198, 35),
        hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
        ),
    ),
    shadowColor: Color.fromARGB(128, 193, 193, 193),
    dialogBackgroundColor: Color.fromARGB(255, 244, 246, 255),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Color.fromARGB(255, 28, 28, 30),
        primary: Color.fromARGB(255, 76, 76, 76),
        secondary: Color.fromARGB(255, 243, 198, 35),
        onPrimary: Color.fromARGB(255, 27, 27, 27),
        onSecondary: Color.fromARGB(255, 225, 225, 225),
        onPrimaryContainer: Color.fromARGB(185, 255, 255, 255),
        onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
        onPrimaryFixed: Color.fromARGB(255, 161, 161, 161),
        inversePrimary: Color.fromARGB(255, 255, 255, 255),
        onInverseSurface: Color.fromARGB(255, 115, 115, 115),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
    ),
    cardColor: Color.fromARGB(255, 76, 76, 76),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 76, 76, 76),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
        selectedItemColor: Color.fromARGB(255, 255, 131, 23),
        unselectedItemColor: Color.fromARGB(255, 112, 112, 112),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 76, 76, 76)),
            foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
        ),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Color.fromARGB(255, 76, 76, 76),
        contentTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
        ),
    ),
    indicatorColor: Color.fromARGB(255, 76, 76, 76),
    shadowColor: Color.fromARGB(255, 55, 55, 55),
    dialogBackgroundColor: Color.fromARGB(255, 76, 76, 76),
);

// class AppColors {
//     static const primary = Color.fromARGB(255, 255, 131, 23);
//     static const secondary = Color.fromARGB(255, 243, 198, 35);
//     static const onPrimary = Color.fromARGB(255, 244, 246, 255);
//     static const onSecondary = Color.fromARGB(255, 16, 55, 92);
// }