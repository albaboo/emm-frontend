import 'package:flutter/material.dart';

class CarerScreen extends StatelessWidget {

  const CarerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuidador')),
      body: const Center(
        child: Text('Pantalla del cuidador'),
      ),
    );
  }
}