import 'package:flutter/material.dart';

import '../../../models/carer_model.dart';

class CarersManagementScreen extends StatelessWidget {
  final List<Carer> carers;

  const CarersManagementScreen({super.key, required this.carers});

  @override
  Widget build(BuildContext context) {
    if (carers.isEmpty) {
      return const Center(child: Text('No hay cuidadores disponibles'));
    }

    return ListView.builder(
      itemCount: carers.length,
      itemBuilder: (context, index) {
        final carer = carers[index];

        return _PersonTile(
          name: '${carer.name ?? ''} ${carer.lastnames ?? ''}'.trim(),
          subtitle: carer.email ?? carer.phone ?? carer.username,
          icon: Icons.diversity_1,
          color: Colors.green,
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
