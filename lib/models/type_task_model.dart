import 'package:flutter/cupertino.dart';

class TypeTask {
  final int? id;
  final String title;
  final IconData icon;
  final Color color;

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
      icon: IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      ),
      color: Color(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": icon.codePoint,
      "color": color.toARGB32(),
    };
  }
}