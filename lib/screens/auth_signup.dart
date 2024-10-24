import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class AuthSignup extends StatefulWidget {
  const AuthSignup({super.key});

  @override
  State<AuthSignup> createState() => _AuthSignupState();
}

class _AuthSignupState extends State<AuthSignup> {
  GlobalKey<FormBuilderState> _globalFormKey = GlobalKey<FormBuilderState>();
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  String? _error; // Error message state

  void _register(Map newUser) async {
    setState(() {
      _error = null; // Reset error before starting a new request
    });

    try {
      final url = Uri.http("10.0.2.2:8000", "/api/user");
      print("Fetching data from: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(newUser),
      );

      print("Response status: ${response.statusCode}");

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to register, please try again later :("; // Display error message
        });
        return;
      }

      print(response.body); // Log the response body for debugging

      final responseData = json.decode(response.body); // Decode the JSON response

      if (response.statusCode == 201 || responseData["success"] == true) {
        print("Registration successful");
        Navigator.pushNamed(context, "/signin"); // Redirect to login after success
      } else {
        setState(() {
          _error = responseData["message"] ?? "Registration failed, please try again."; // Show API error message
        });
      }
    } catch (e) {
      setState(() {
        _error = "Something went wrong, please try again :("; // Handle error
      });
      print("Error: $e");
    }
  }

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
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Bagian form register
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: FormBuilder(
              key: _globalFormKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'username',
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: FormBuilderValidators.required(),
                    onSaved: (value) => username = value,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    onSaved: (value) => email = value,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.required(),
                    onSaved: (value) => password = value,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'confirmPassword',
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (val) {
                        if (val != password) {
                          return "Passwords do not match";
                        }
                        return null;
                      }
                    ]),
                    onSaved: (value) => confirmPassword = value,
                  ),
                  const SizedBox(height: 20),
                  if (_error != null) // Display error if it exists
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (_globalFormKey.currentState?.saveAndValidate() ?? false) {
                        final formValues = _globalFormKey.currentState?.value;
                        debugPrint(formValues.toString());
                        _register(formValues!); // Pass the form values to _register
                      } else {
                        debugPrint("Validation failed");
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Bagian navigasi ke login
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
                    text: "Already have an account? ",
                  ),
                  TextSpan(
                    text: "Login",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, "/signin");
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
        body: _registerUI(context),
      ),
    );
  }
}
