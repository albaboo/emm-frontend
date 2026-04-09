

import 'package:flutter/material.dart';
import 'CarerScreen.dart';
import 'HospitalScreen.dart';
import 'MedicalScreen.dart';
import 'PatientScreen.dart';

class Userscreen extends StatelessWidget {
  const Userscreen({super.key});

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

                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.blue,
                      size: 45,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'EMM',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2A3A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Cuidado y apoyo para ti y los tuyos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF4A5568),
                    ),
                  ),

                  const SizedBox(height: 50),

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
                        iconColor: Colors.blue,
                        background: const Color(0xFFDDEBFF),
                        borderColor: const Color(0xFF7CB3FF),
                        screen: const PatientScreen(),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Familiar / Cuidador',
                        subtitle: 'Acompaña ysupervisa',
                        icon: Icons.groups_outlined,
                        iconColor: Colors.green,
                        background: const Color(0xFFD9F7E4),
                        borderColor: const Color(0xFF63D98A),
                        screen: const CarerScreen(),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Profesional\nde Salud',
                        subtitle: 'Gestiona pacientes',
                        icon: Icons.medical_services_outlined,
                        iconColor: Colors.purple,
                        background: const Color(0xFFF0E2FF),
                        borderColor: const Color(0xFFD1A3FF),
                        screen: const MedicalScreen(),
                      ),
                      _buildRoleCard(
                        context,
                        title: 'Hospital',
                        subtitle: 'Administra usuarios',
                        icon: Icons.business_outlined,
                        iconColor: Colors.cyan,
                        background: const Color(0xFFDDF7FB),
                        borderColor: const Color(0xFF48D4F2),
                        screen: const HospitalScreen(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Selecciona tu rol para continuar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A5568),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
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