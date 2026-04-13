import 'package:emm_app/core/enums/user_types.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/image.dart';
import '../../core/widgets/textfield.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final UserType type;

  const LoginScreen({super.key, required this.type});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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

                          ButtonWidget(
                            text: 'Continuar',
                            onPressed: () async {
                              final user = usernameController.text;
                              final pass = passwordController.text;

                              setState(() => isLoading = true);

                              try {
                                if (user.isEmpty || pass.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Completa todos los campos',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final result = await authService.login(
                                  user,
                                  pass,
                                  widget.type,
                                );

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message']),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                //final token = result['token'];
                                //final userData = result['user'];

                                //TODO: Añadir preferencias y guardar token
                                //TODO: Redirigir a pantalla correspondiente
                                //TODO: Mirar donde guardar el user
                                // Navigator.pushReplacementNamed(context, '/home');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Inicio de sesión fallido'),
                                  ),
                                );
                              } finally {
                                if (mounted) setState(() => isLoading = false);
                              }
                            },
                          ),
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
