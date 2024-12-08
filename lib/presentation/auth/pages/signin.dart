import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
                "assets/images/icon.png",
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
          FormBuilder(
            child: Padding(
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
                    text: "Belum memiliki akun? ",
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
    return FormBuilderTextField(
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
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
      name: 'email',
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
        backgroundColor: Colors.yellow.shade800,
        minimumSize: const Size(double.infinity, 50),
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
