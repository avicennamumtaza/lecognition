import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecognition/core/configs/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool isDarkMode = false;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

// class AppTheme {
//   static final appTheme = ThemeData(
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Color.fromARGB(255, 52, 121, 40),
//       brightness: Brightness.light, // Untuk memastikan warna terang
//     ).copyWith(
//       primary: AppColors.primary, // Set warna primary secara eksplisit
//       secondary: AppColors.secondary, // Set warna secondary secara eksplisit
//       onPrimary:
//           AppColors.onPrimary, // Set warna teks pada primary secara eksplisit
//       onSecondary: AppColors
//           .onSecondary, // Set warna teks pada secondary secara eksplisit
//     ),
//     textTheme: GoogleFonts.poppinsTextTheme(),
//     extensions: const [
//       SkeletonizerConfigData(),
//     ],
//     primaryColor: AppColors.primary,
//     scaffoldBackgroundColor: Colors.white,
//     brightness: Brightness.light,
//     snackBarTheme: SnackBarThemeData(
//       backgroundColor: AppColors.onSecondary,
//       contentTextStyle: TextStyle(
//         color: Colors.blueGrey.shade900,
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.secondary,
//       hintStyle: const TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.w400,
//       ),
//       contentPadding: const EdgeInsets.all(16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//       ),
//     ),
//   );
// }
