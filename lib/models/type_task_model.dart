import 'package:flutter/cupertino.dart';

class TypeTask {
  final int? id;
  final String title;
  final int icon;
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

  IconData get iconData => IconData(icon, fontFamily: 'MaterialIcons');

  Color get colorValue => Color(color);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": icon,
      "color": color,
    };
  }
}