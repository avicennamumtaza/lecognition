import 'package:flutter/material.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('plant_detail'),
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}