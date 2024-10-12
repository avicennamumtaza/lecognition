import 'dart:io';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.photo});
  final File photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result Screen')),
      body: Center(
        child: Image.file(photo), // Displays the image
      ),
    );
  }
}