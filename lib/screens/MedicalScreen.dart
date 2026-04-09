import 'package:flutter/material.dart';

class MedicalScreen extends StatelessWidget {

  const MedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical')),
      body: const Center(
        child: Text('Pantalla del medico'),
      ),
    );
  }
}