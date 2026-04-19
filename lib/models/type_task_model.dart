import 'package:flutter/material.dart';

class TypeTask {
  // Mapa de iconos disponibles como constantes
  static const Map<int, IconData> availableIcons = {
    0: Icons.task,
    1: Icons.medication_liquid,
    2: Icons.home,
    3: Icons.phone,
    4: Icons.menu_book,
    5: Icons.coffee,
    6: Icons.bathtub,
    7: Icons.restaurant_menu,
    8: Icons.live_tv,
  };

  final int? id;
  final String title;
  final int icon; // índice del icono en availableIcons
  final int color;

  TypeTask({
    this.id,
    required this.title,
    required this.icon,
    required this.color,
  });

  factory TypeTask.fromJson(Map<String, dynamic> json) {
    return TypeTask(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
    );
  }

  /// Retorna el IconData del mapa de iconos disponibles
  IconData get iconData => availableIcons[icon] ?? Icons.task;

  Color get colorValue => Color(color);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": icon,
      "color": color,
    };
  }
}