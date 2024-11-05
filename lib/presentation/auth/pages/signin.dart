import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/common/widgets/tabs.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/domain/auth/usecases/signin.dart';
import 'package:lecognition/presentation/auth/pages/signup.dart';
import 'package:lecognition/service_locator.dart';

class SigninPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian logo dan dekorasi
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
            child: Center(
              child: Image.asset(
                "assets/images/logojti.png",
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              "Masuk",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Bagian form login
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(children: [
              _emailField(),
              const SizedBox(height: 15),
              _passwordField(),
              const SizedBox(height: 30),
              _signinButton(context),
              const SizedBox(height: 10),
            ]),
          ),
          const SizedBox(height: 50),
          // Bagian Sign Up
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Don't have an account? ",
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppNavigator.push(context, SignupPage());
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow.shade800, // warna tombol
        minimumSize: const Size(double.infinity, 50), // ukuran tombol
      ),
      onPressed: () async {
        try {
          final result = await sl<SigninUseCase>().call(
            params: SigninReqParams(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
          result.fold(
            (failure) {
              DisplayMessage.errorMessage(context, failure.toString());
            },
            (success) {
              AppNavigator.pushAndRemove(
                context,
                const TabsScreen(index: 0),
              );
            },
          );
        } catch (error) {
          DisplayMessage.errorMessage(context, error.toString());
        }
      },
      child: const Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget _signupText(BuildContext context) {
  //   return Text.rich(
  //     TextSpan(
  //       children: [
  //         const TextSpan(
  //           text: "Don't have an account?",
  //         ),
  //         TextSpan(
  //           text: "  Let's Sign Up here.",
  //           style: const TextStyle(
  //             color: Colors.blue,
  //           ),
  //           recognizer: TapGestureRecognizer()
  //             ..onTap = () {
  //               AppNavigator.push(context, SignupPage());
  //             },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _loginUI(context),
      ),
    );
  }
}
