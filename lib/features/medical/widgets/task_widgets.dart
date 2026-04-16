import 'package:flutter/material.dart';

Widget sectionTile({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required List<String> items,
  VoidCallback? onAdd,
}) {
  return ExpansionTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        if (onAdd != null)
          GestureDetector(
            onTap: onAdd,
            child: const Icon(Icons.add, size: 20),
          ),
      ],
    ),
    subtitle: Text(subtitle),
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