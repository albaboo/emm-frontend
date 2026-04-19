import 'package:flutter/material.dart';

Widget sectionTile({
  required BuildContext context,
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required List<String> items,
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
    children: items.map((e) => taskItem(e)).toList(),
  );
}

Widget taskItem(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Text(title),
  );
}
