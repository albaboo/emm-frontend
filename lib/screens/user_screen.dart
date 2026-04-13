import 'package:emm_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../core/enums/user_types.dart';
import '../core/widgets/image.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: ImageWidget(),
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
                    'Selecciona tu rol para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Color(0xFF4A5568)),
                  ),

                  const SizedBox(height: 40),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildRoleCard(
                        context,
                        title: 'Paciente',
                        subtitle: 'Accede a tus tareas diarias',
                        icon: Icons.favorite_border,
                        iconColor: Colors.purple,
                        background: const Color(0xFFE8DDFF),
                        borderColor: const Color(0xFFA87CFF),
                        screen: LoginScreen(type: UserType.patient),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Cuidador',
                        subtitle: 'Acompaña y supervisa',
                        icon: Icons.diversity_1,
                        iconColor: Colors.green,
                        background: const Color(0xFFD9F7E4),
                        borderColor: const Color(0xFF63D98A),
                        screen: LoginScreen(type: UserType.carer),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Profesional\nde Salud',
                        subtitle: 'Gestiona pacientes',
                        icon: Icons.medical_services_outlined,
                        iconColor: const Color.fromARGB(255, 176, 39, 48),
                        background: const Color(0xFFF0E2FF),
                        borderColor: const Color.fromARGB(255, 222, 145, 145),
                        screen: LoginScreen(type: UserType.medical),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Hospital',
                        subtitle: 'Administra usuarios',
                        icon: Icons.apartment,
                        iconColor: Colors.cyan,
                        background: const Color(0xFFDDF6FB),
                        borderColor: const Color(0xFF48D3F2),
                        screen: LoginScreen(type: UserType.admin),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Develop with love by Alba & Oumayma',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Color(0xFF4A5568)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color background,
    required Color borderColor,
    required Widget screen,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        width: 220,
        height: 320,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 45, color: iconColor),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D2A3A),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF4A5568),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
