import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lecognition/widgets/tabs.dart';
import 'package:skeletonizer/skeletonizer.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 0, 155, 0),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
  extensions: const [
    SkeletonizerConfigData(),
  ],
);

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize the available cameras and pass them to the CameraApp
//   final cameras = await availableCameras();
//   runApp(CameraApp(cameras: cameras));
// }

// /// CameraApp is the Main Application.
// class CameraApp extends StatelessWidget {
//   /// Constructor to accept cameras list
//   const CameraApp({super.key, required this.cameras});
//   final List<CameraDescription> cameras;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraScreen(cameras: cameras), // Navigate to CameraScreen
//     );
//   }
// }

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Flutter Demo',
      home: const TabsScreen(),
    );
  }
}
