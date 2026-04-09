import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paciente')),
      body: const Center(
        child: Text('Pantalla del paciente'),
      ),
    );
  }
}