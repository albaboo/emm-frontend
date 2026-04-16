import 'package:emm_app/core/session/session_actions.dart';
import 'package:flutter/material.dart';

class CarerScreen extends StatelessWidget {

  const CarerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidador'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesion',
            onPressed: () => SessionActions.logout(
              context,
              message: 'Sesion cerrada',
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Pantalla del cuidador'),
      ),
    );
  }
}