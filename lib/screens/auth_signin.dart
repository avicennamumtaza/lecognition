import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:lecognition/widgets/tabs.dart';
// import 'package:lecognition/widgets/tabs.dart';

class AuthSignin extends StatefulWidget {
  const AuthSignin({super.key});

  @override
  State<AuthSignin> createState() => _AuthSigninState();
}

class _AuthSigninState extends State<AuthSignin> {
  GlobalKey<FormBuilderState> _globalFormKey = GlobalKey<FormBuilderState>();
  String? username;
  String? password;
  // String? _error;

  // void _register(Map newUser) async {
  //   if (newUser["username"] == "database") {

  //   }
  // }

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
            child: FormBuilder(
              key: _globalFormKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'username',
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(10)
                    ]),
                    onSaved: (value) => username = value,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.required(),
                    onSaved: (value) => password = value,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (_globalFormKey.currentState?.saveAndValidate() ??
                          false) {
                        final formValues = _globalFormKey.currentState?.value;
                        debugPrint(formValues.toString());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TabsScreen(index: 0),
                          ),
                          (Route<dynamic> route) =>
                              false, // Remove all previous routes
                        );
                      } else {
                        debugPrint("Validation failed");
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: ThemeData().colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        print("Forgot Password tapped");
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                        Navigator.pushNamed(context, "/signup");
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
