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
import '../admin/admin_screen.dart';
import '../carer_screen.dart';
import '../medical/medical_screen.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F3FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 24,
        toolbarHeight: 82,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ImageWidget(
                  path: 'assets/icon/icon_desktop.png',
                  width: 48,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Every Memory Matters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D2A3A),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildRoleHeader(),
                  const SizedBox(height: 20),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(data)),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() => isLoading = false);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 300,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.arrow_back_rounded, size: 26),
                      label: const Text(
                        'Volver atrás',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5E7EB),
                        foregroundColor: const Color(0xFF1D2A3A),
                        elevation: 3,
                        shadowColor: Colors.black26,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
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

  Widget _buildRoleHeader() {
    final config = _roleConfig(widget.type);

    return SizedBox(
      width: 300,
      height: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 118,
            height: 118,
            decoration: BoxDecoration(
              color: config.background,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              config.icon,
              size: 60,
              color: config.iconColor,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: config.background,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: config.borderColor, width: 1.5),
            ),
            child: Text(
              config.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: config.iconColor,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _RoleHeaderConfig _roleConfig(UserType type) {
    switch (type) {
      case UserType.patient:
        return const _RoleHeaderConfig(
          label: 'Paciente',
          icon: Icons.favorite_border,
          iconColor: Color(0xFF8A4DFF),
          background: Color(0xFFE8DDFF),
          borderColor: Color(0xFFA87CFF),
        );
      case UserType.carer:
        return const _RoleHeaderConfig(
          label: 'Cuidador',
          icon: Icons.diversity_1,
          iconColor: Color(0xFF2E9E57),
          background: Color(0xFFD9F7E4),
          borderColor: Color(0xFF63D98A),
        );
      case UserType.medical:
        return const _RoleHeaderConfig(
          label: 'Médico',
          icon: Icons.medical_services,
          iconColor: Color.fromARGB(255, 176, 39, 48),
          background: Color(0xFFF0E2FF),
          borderColor: Color.fromARGB(255, 222, 145, 145),
        );
      case UserType.admin:
        return const _RoleHeaderConfig(
          label: 'Admin',
          icon: Icons.apartment,
          iconColor: Color(0xFF009BB8),
          background: Color(0xFFDDF6FB),
          borderColor: Color(0xFF48D3F2),
        );
    }
  }
}

class _RoleHeaderConfig {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color background;
  final Color borderColor;

  const _RoleHeaderConfig({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.borderColor,
  });
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
