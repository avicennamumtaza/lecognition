import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/presentation/auth/pages/signin.dart';
// import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:lecognition/presentation/splash/bloc/splash_cubit.dart';
import 'package:lecognition/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/widgets/tabs.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(
              context,
              SigninPage(),
            );
          } else if (state is Authenticated) {
            AppNavigator.pushReplacement(
              context,
              TabsScreen(
                index: 0,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              // height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppImages.splashBackground,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
