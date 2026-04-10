import 'package:flutter/material.dart';

import 'screens/user_screen.dart';

void main() => runApp(const EmmApp());

class EmmApp extends StatelessWidget {
  const EmmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMM',
      debugShowCheckedModeBanner: false,
      home: const UserScreen(),
    );
  }
}