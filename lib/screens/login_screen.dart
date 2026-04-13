import 'package:emm_app/components/my_button.dart';
import 'package:emm_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../widgets/logoEmm_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  const Text(
                    'Inicia sesión',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2A3A),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // card de login
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          MyTextfield(
                            controller: usernameController,
                            hintText: 'Username',
                            obscureText: false,
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          MyTextfield(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            icon: Icons.lock,
                          ),
                          const SizedBox(height: 30),
                          MyButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
