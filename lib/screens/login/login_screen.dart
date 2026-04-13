import 'package:emm_app/core/enums/user_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/image.dart';
import '../../core/widgets/textfield.dart';
import '../../factories/user_factory.dart';
import '../../providers/user_provider.dart';
import '../../services/auth_service.dart';
import '../../services/storage_service.dart';
import '../admin_screen.dart';
import '../carer_screen.dart';
import '../medical_screen.dart';
import '../patient_screen.dart';

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
                              final username = usernameController.text;
                              final password = passwordController.text;

                              setState(() => isLoading = true);

                              try {
                                if (username.isEmpty || password.isEmpty) {
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
                                  username,
                                  password,
                                  widget.type,
                                );

                                await StorageService.saveToken(result['token']);

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message']),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                if (context.mounted) {
                                  context.read<UserProvider>().setUser(
                                    UserFactory.fromJson(result['user']),
                                  );
                                }

                                final user = context.read<UserProvider>().user;

                                if (user != null) {
                                  final nextScreen = _getHomeScreen(user.type);

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => nextScreen,
                                    ),
                                    (route) => false,
                                  );
                                }
                              } on Error catch (e) {
                                final data = e.toString();
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(data)));
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

Widget _getHomeScreen(UserType type) {
  switch (type) {
    case UserType.patient:
      return const PatientScreen();
    case UserType.medical:
      return const MedicalScreen();
    case UserType.carer:
      return const CarerScreen();
    case UserType.admin:
      return const AdminScreen();
  }
}
