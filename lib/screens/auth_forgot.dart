import 'package:flutter/material.dart';

class AuthForgot extends StatefulWidget {
  const AuthForgot({super.key});

  @override
  State<AuthForgot> createState() => _AuthForgotState();
}

class _AuthForgotState extends State<AuthForgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auth_forgot'),
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
