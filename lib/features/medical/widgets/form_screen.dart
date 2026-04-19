import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_widgets.dart';
import '../../../providers/typetask_provider.dart';
import '../../../models/typetask_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _taskController = TextEditingController();

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

    Future.microtask(() {
      context.read<TypeTaskProvider>().loadTasks();
    });
  }

  void _openAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Añadir tarea"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: "Título de la tarea",
                    ),
                  ),
                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 8,
                    children: _icons.map((icon) {
                      return GestureDetector(
                        onTap: () {
                          setStateDialog(() => _selectedIcon = icon);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _selectedIcon == icon
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(icon),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 10,
                    children: _colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setStateDialog(() => _selectedColor = color);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _selectedColor == color
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
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final task = TypeTask(
                      title: _taskController.text,
                      icon: _selectedIcon.codePoint.toString(),
                      color: _selectedColor.value.toString(),
                    );

                    await context
                        .read<TypeTaskProvider>()
                        .createTask(task.toJson());

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

                    void _openAddGroupDialog() {
                    final TextEditingController _groupController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Añadir grupo"),
                          content: TextField(
                            controller: _groupController,
                            decoration: const InputDecoration(
                              labelText: "Nombre del grupo",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancelar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Aquí llamas a tu provider de grupos
                                print(_groupController.text);

                                Navigator.pop(context);
                              },
                              child: const Text("Añadir"),
                            ),
                          ],
                        );
                      },
                    );
                  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypeTaskProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 25),

              //  TITULO
              const Text(
                'Panel Profesional',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2A3A),
                ),
              ),

              const SizedBox(height: 20),

              //  STATS
              Row(
                children: [
                  Expanded(
                    child: _Stat(
                      "Configuracion",
                      provider.tasks.length,
                      icon: Icons.settings,
                      iconColor: Colors.lightGreen,
                      isSelected: true,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _Stat(
                      "Pacientes",
                      _icons.length,
                      icon: Icons.account_box,
                      iconColor: Colors.purple,
                      isSelected: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _Stat(
                      "Alertas Activas",
                      _colors.length,
                      icon: Icons.add_alert,
                      iconColor: Colors.orange,
                      isSelected: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _Stat(
                      "Tareas Hoy",
                      provider.tasks.length,
                      icon: Icons.access_time,
                      iconColor: Colors.blueGrey,
                      isSelected: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // list
               Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return sectionTile(
                        icon: Icons.checklist_rtl,
                        color: const Color(0xFF7BCFA6),
                        title: "Tipo de Tareas",
                        subtitle: "Tareas creadas",
                        items: provider.tasks.map((t) => t.title).toList(),
                        onAdd: _openAddTaskDialog,
                      );
                    }

                    if (index == 1) {
                      return sectionTile(
                        icon: Icons.auto_awesome_mosaic,
                        color: const Color(0xFFA7A6F2),
                        title: "Grupo de Tareas",
                        subtitle: "Lista de grupos",
                        items: provider.tasks.map((t) => t.title).toList(),
                        onAdd: _openAddGroupDialog,
                      );
                    }

                    return sectionTile(
                      icon: Icons.contact_support,
                      color: const Color(0xFFF2C36B),
                      title: "Guía de Ayuda",
                      subtitle: "Pasos de ayuda",
                      items: ["Paso 1", "Paso 2", "Paso 3"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;

  const _Stat(
    this.label,
    this.value, {
    required this.icon,
    required this.iconColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? iconColor
              : iconColor.withValues(alpha: 0.3),
          width: isSelected ? 2.5 : 1.5,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TEXTO IZQUIERDA
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2A3A),
                ),
              ),
            ],
          ),

          // ICONO DERECHA
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 32),
          ),
        ],
      ),
    );
  }
}
