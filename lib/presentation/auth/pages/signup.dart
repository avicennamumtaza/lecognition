import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/widgets/form.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/domain/auth/usecases/signup.dart';
import 'package:lecognition/presentation/auth/pages/signin.dart';
import 'package:lecognition/service_locator.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

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
                "assets/images/icon.png",
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
              _buildFormFields(),
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
                    text: "Masuk",
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

  Widget _buildFormFields() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBoilerplate.buildTextField(
            'e-mail',
            'E-mail',
            'Enter e-mail',
            Icons.email,
            _emailController,
            TextInputType.emailAddress,
            [
              FormBuilderValidators.required(errorText: "Email tidak boleh kosong"),
              FormBuilderValidators.email(errorText: "Email tidak valid"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'username',
            'Username',
            'Enter username', // Updated hintText
            Icons.person,
            _usernameController,
            TextInputType.text,
            [
              FormBuilderValidators.required(errorText: "Username tidak boleh kosong"),
              FormBuilderValidators.minLength(6, errorText: "Username minimal 6 karakter"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'password',
            'Password',
            'Enter new password', // Default hintText for password
            Icons.lock,
            _passwordController,
            TextInputType.text,
            [
              FormBuilderValidators.required(errorText: "Password tidak boleh kosong"),
              FormBuilderValidators.minLength(6, errorText: "Password minimal 6 karakter"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      child: _isSubmitting
          ? CircularProgressIndicator()
          : const Text(
              "Daftar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow.shade800, // warna tombol
        minimumSize: const Size(double.infinity, 50), // ukuran tombol
      ),
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          setState(() => _isSubmitting = true);
          try {
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
            print(result);
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
          } catch (error) {
            DisplayMessage.errorMessage(context, error.toString());
          }
          finally {
            setState(() => _isSubmitting = false);
          }
        }
      },
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
