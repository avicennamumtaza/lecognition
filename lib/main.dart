import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lecognition/camera_app.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 0, 155, 0),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the available cameras and pass them to the CameraApp
  final cameras = await availableCameras();
  runApp(CameraApp(cameras: cameras));
}

/// CameraApp is the Main Application.
class CameraApp extends StatelessWidget {
  /// Constructor to accept cameras list
  const CameraApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(cameras: cameras), // Navigate to CameraScreen
    );
  }
}

// void main() {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // Display splash screen until initialization completes
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove(); // Remove splash screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            floating: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(20),
                          // child: const Center(
                          //   child: Text(
                          //     "Carousel berisi\ninformasi2 yg eye catching",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                          child: const Center(
                            child: Text(
                              "Selamat tinggal penyakit mangga! Pindai daun, dapatkan diagnosis, dan rawat tanaman Anda dengan mudah."
                                "Dapatkan hasil panen mangga yang optimal dengan menjaga kesehatan tanaman Anda menggunakan aplikasi ini.",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 100,
                        //   decoration: BoxDecoration(
                        //     color: Colors.green.shade300,
                        //     borderRadius: BorderRadius.circular(12),
                        //   ),
                        //   child: const Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(Icons.camera_alt,
                        //           size: 40, color: Colors.white),
                        //       SizedBox(height: 8),
                        //       Text(
                        //         'Scanner',
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Content $index',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              childCount: 100, // Number of rows
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            activeIcon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
