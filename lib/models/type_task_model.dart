class TypeTask {
  final int? id;
  final String title;
  final String icon;
  final String color;

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

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": icon,
      "color": color,
    };
  }
}