import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true; // loading animation

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove(); // Remove splash screen
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: SpinKitSquareCircle(
              color: Colors.green,
              size: 50.0,
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width / 2,
                floating: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: AutoSizeText(
                            "Selamat Pagi Lukman!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(
                        top: index == 0 ? 20.0 : 15.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: index == 0 ? 10 : 10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Content $index',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  childCount: 100, // Number of rows
                ),
              ),
            ],
          );
  }
}
