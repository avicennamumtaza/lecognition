import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/domain/auth/usecases/signup.dart';
import 'package:lecognition/presentation/auth/pages/signin.dart';
import 'package:lecognition/service_locator.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _registerUI(BuildContext context) {
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
              "Daftar",
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
              _usernameField(),
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
                    text: "Sudah memiliki akun? ",
                  ),
                  TextSpan(
                    text: "Sign In",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppNavigator.push(context, SigninPage());
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
      decoration: InputDecoration(
        hintText: "Email",
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _usernameField() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: "Username",
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow.shade800, // warna tombol
        minimumSize: const Size(double.infinity, 50), // ukuran tombol
      ),
      onPressed: () async {
        // try {
        print(_emailController.text);
        print(_usernameController.text);
        print(_passwordController.text);
        final result = await sl<SignupUseCase>().call(
          params: SignupReqParams(
            email: _emailController.text,
            username: _usernameController.text,
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
              SigninPage(),
            );
          },
        );
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _registerUI(context),
      ),
    );
  }
}
