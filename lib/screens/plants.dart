import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('plantsScreen'),
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}