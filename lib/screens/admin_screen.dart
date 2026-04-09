import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {

  const AdminScreen({super.key});

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