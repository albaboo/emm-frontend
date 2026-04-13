import 'package:emm_app/core/widgets/button.dart';
import 'package:emm_app/core/widgets/textfield.dart';
import 'package:flutter/material.dart';

import '../core/widgets/image.dart';

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
                  SizedBox(
                    width: 300,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: ImageWidget(path: 'assets/icon/icon_desktop.png'),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Every Memory Matters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2A3A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Cerca en el cuidado, presente en cada momento',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Color(0xFF4A5568)),
                  ),

                  const SizedBox(height: 50),

                  const Text(
                    'Iniciar sesión',
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
                          InputTextWidget(
                            controller: usernameController,
                            hintText: 'Username',
                            obscureText: false,
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          InputTextWidget(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            icon: Icons.lock,
                          ),
                          const SizedBox(height: 30),
                          ButtonWidget(text: 'Continuar'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  const Text(
                    'EMM by Alba & Oumayma',
                    style: TextStyle(fontSize: 18, color: Color(0xFF4A5568)),
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
