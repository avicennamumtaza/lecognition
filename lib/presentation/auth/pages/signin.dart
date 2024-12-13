import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/widgets/form.dart';
import 'package:lecognition/widgets/tabs.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/domain/auth/usecases/signin.dart';
import 'package:lecognition/presentation/auth/pages/signup.dart';
import 'package:lecognition/service_locator.dart';

class SigninPage extends StatefulWidget {
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian logo dan dekorasi
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
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
                // color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Bagian form login
          FormBuilder(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                _buildFormFields(),
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
                // color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Belum memiliki akun? ",
                  ),
                  TextSpan(
                    text: "Daftar",
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
            context,
            [
              FormBuilderValidators.required(errorText: "Email tidak boleh kosong"),
              FormBuilderValidators.email(errorText: "Email tidak valid"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'password',
            'Password',
            'Enter new password',
            Icons.lock,
            _passwordController,
            TextInputType.text,
            context,
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow.shade800,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          setState(() => _isSubmitting = true);
          try {
            print("Email: ${_emailController.text}");
            print("Password: ${_passwordController.text}");
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
          finally {
            setState(() => _isSubmitting = false);
          }
        }
      },
      child: _isSubmitting
          ? CircularProgressIndicator()
          : const Text(
              "Masuk",
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
        body: _loginUI(context),
      ),
    );
  }
}
