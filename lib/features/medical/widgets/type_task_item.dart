import 'package:flutter/material.dart';

import '../../../models/type_task_model.dart';

Widget sectionTile({
  required BuildContext context,
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required List<TypeTask> items,
  VoidCallback? onAdd,
}) {
  final isMobile = MediaQuery.of(context).size.width < 760;

  return ExpansionTile(
    leading: Container(
      padding: EdgeInsets.all(isMobile ? 6 : 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: isMobile ? 20 : 24),
    ),
    title: LayoutBuilder(
      builder: (context, constraints) {
        final useColumn = constraints.maxWidth < 220;

        if (useColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              if (onAdd != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 18),
                          SizedBox(width: 4),
                          Text("Añadir"),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 14 : 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onAdd != null)
              GestureDetector(
                onTap: onAdd,
                child: const Icon(Icons.add, size: 20),
              ),
          ],
        );
      },
    ),
    subtitle: Text(subtitle, style: TextStyle(fontSize: isMobile ? 12 : 14)),
    children: items.map(taskItem).toList(),
  );
}

Widget taskItem(TypeTask task) {
  final color = task.color;
  final borderColor = Color.alphaBlend(
    Colors.black.withValues(alpha: 0.15),
    color,
  );

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: borderColor, width: 2),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            task.icon,
            size: 28,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            task.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D2A3A),
            ),
          ),
        ),
      ],
    ),
  );
}