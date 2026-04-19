import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/type_task_model.dart';
import 'package:emm_app/providers/type_task_provider.dart';
import 'type_task_item.dart';

class SettingsManagementScreen extends StatefulWidget {
  const SettingsManagementScreen({super.key});

  @override
  State<SettingsManagementScreen> createState() =>
      _SettingsManagementScreenState();
}

class _SettingsManagementScreenState extends State<SettingsManagementScreen> {
  final TextEditingController _taskController = TextEditingController();

  static const double _mobileBreakpoint = 760;

  IconData _selectedIcon = Icons.task;
  Color _selectedColor = Colors.blue;

  final List<Color> _colors = [
    const Color(0xFF8DB2D1),
    const Color(0xFFE25A51),
    const Color(0xFFE0D56D),
    const Color(0xFF39723B),
    const Color(0xFF6B2977),
    const Color(0xFF74562A),
  ];

  final List<IconData> _icons = [
    Icons.task,
    Icons.medication_liquid,
    Icons.home,
    Icons.phone,
    Icons.menu_book,
    Icons.coffee,
    Icons.bathtub,
    Icons.restaurant_menu,
    Icons.live_tv,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TypeTaskProvider>().loadTasks();
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _openAddTaskDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < _mobileBreakpoint;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Añadir tarea"),
              content: SizedBox(
                width: isMobile ? screenWidth * 0.9 : 560,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _taskController,
                        decoration: const InputDecoration(
                          labelText: "Título de la tarea",
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Icono",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _icons.map((icon) {
                          final selected = _selectedIcon == icon;

                          return GestureDetector(
                            onTap: () {
                              setStateDialog(() => _selectedIcon = icon);
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.grey.shade300
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selected
                                      ? Colors.blueGrey
                                      : Colors.black12,
                                  width: selected ? 2 : 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(icon, size: 22),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Color",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _colors.map((color) {
                          final selected = _selectedColor == color;

                          return GestureDetector(
                            onTap: () {
                              setStateDialog(() => _selectedColor = color);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_taskController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("El título de la tarea es obligatorio"),
                        ),
                      );
                      return;
                    }

                    final task = TypeTask(
                      title: _taskController.text,
                      icon: _selectedIcon.codePoint.toString(),
                      color: _selectedColor.toARGB32().toString(),
                    );

                    await context.read<TypeTaskProvider>().createTask(
                      task.toJson(),
                    );

                    if (!context.mounted) return;
                    _taskController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Añadir"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TypeTaskProvider>();

    return ListView(
      children: [
        sectionTile(
          context: context,
          icon: Icons.checklist_rtl,
          color: const Color(0xFF7BCFA6),
          title: "Tipo de Tareas",
          subtitle: "Tareas creadas",
          items: taskProvider.tasks,
          onAdd: _openAddTaskDialog,
        ),
        _simpleInfoTile(
          icon: Icons.auto_awesome_mosaic,
          color: const Color(0xFFA7A6F2),
          title: "Grupo de Tareas",
          subtitle: "Por ahora no se muestra la lista",
        ),
        _simpleInfoTile(
          icon: Icons.contact_support,
          color: const Color(0xFFF2C36B),
          title: "Guía de Ayuda",
          subtitle: "Por ahora no se muestra la lista",
        ),
      ],
    );
  }

  // Temporal hasta que se implementen los otros tipos de configuración
  Widget _simpleInfoTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    final isMobile = MediaQuery.of(context).size.width < _mobileBreakpoint;

    return ExpansionTile(
      leading: Container(
        padding: EdgeInsets.all(isMobile ? 6 : 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: isMobile ? 20 : 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 14 : 16,
        ),
      ),
      subtitle: Text(subtitle, style: TextStyle(fontSize: isMobile ? 12 : 14)),
      children: const [SizedBox.shrink()],
    );
  }
}
