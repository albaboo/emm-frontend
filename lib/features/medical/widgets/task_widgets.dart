import 'package:flutter/material.dart';

Widget taskItem(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),

        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ],
        )
      ],
    ),
  );
}


Widget sectionTile({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required List<String> items,
}) {
  return ExpansionTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white),
    ),
    title: Text(title),
    subtitle: Text(subtitle),
    children: items.map((item) => taskItem(item)).toList(),
  );
}