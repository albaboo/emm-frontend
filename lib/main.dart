import 'package:emm_app/screens/login/login_screen.dart';
import 'package:emm_app/screens/medical/form_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/user_screen.dart';

void main() => runApp(const EmmApp());

class EmmApp extends StatelessWidget {
  const EmmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'EMM',
      debugShowCheckedModeBanner: false,
     // home: LoginScreen(),
    // home: const UserScreen(),
     home: FormScreen(),
    );
  }
}