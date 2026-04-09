import 'package:flutter/material.dart';

class Hospitalscreen extends StatelessWidget {

  const Hospitalscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hospital')),
      body: const Center(
        child: Text('Pantalla del hospital'),
      ),
    );
  }
}