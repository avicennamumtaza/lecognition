import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:lecognition/core/configs/theme/app_theme.dart';
import 'package:lecognition/screens/auth_signin.dart';
import 'package:lecognition/screens/auth_signup.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lecognition/screens/bookmarked.dart';
import 'package:lecognition/widgets/tabs.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// final theme = ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Color.fromARGB(255, 52, 121, 40,),
//     brightness: Brightness.light, // Untuk memastikan warna terang
//   ).copyWith(
//     primary: Color.fromARGB(255, 52, 121, 40), // Set warna primary secara eksplisit
//     secondary: Color.fromARGB(255, 192, 235, 166), // Set warna secondary secara eksplisit
//     onPrimary: Color.fromARGB(255, 255, 251, 230), // Set warna teks pada primary secara eksplisit
//     onSecondary: Color.fromARGB(255, 255, 255, 255), // Set warna teks pada secondary secara eksplisit
//   ),
//   textTheme: GoogleFonts.poppinsTextTheme(),
//   extensions: const [
//     SkeletonizerConfigData(),
//   ],
// );

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      // localizationsDelegates: ,
      // supportedLocales: ,
      title: 'Flutter Demo',
      initialRoute: "/signup",
      routes: {
        '/signup': (context) => const AuthSignup(),
        '/signin': (context) => const AuthSignin(),
        '/': (context) => const TabsScreen(),
        '/bookmarked': (context) => BookmarkedScreen(),
      },
      // home: const TabsScreen(),
    );
  }
}
