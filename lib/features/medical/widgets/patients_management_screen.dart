import 'package:flutter/material.dart';

import '../../../models/patient_model.dart';

class PatientsManagementScreen extends StatelessWidget {
  final List<Patient> patients;

  const PatientsManagementScreen({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return const Center(child: Text('No hay pacientes disponibles'));
    }

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];

        return _PersonTile(
          name: '${patient.name ?? ''} ${patient.lastnames ?? ''}'.trim(),
          subtitle: patient.email ?? patient.phone ?? patient.username,
          icon: Icons.favorite_outline,
          color: Colors.purple,
        );
      },
    );
  }
}

class _PersonTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _PersonTile({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? 'Sin nombre' : name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D2A3A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFF4A5568)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
