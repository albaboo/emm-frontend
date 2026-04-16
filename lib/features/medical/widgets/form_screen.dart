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
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  final List<IconData> _icons = [
    Icons.task,
    Icons.work,
    Icons.home,
    Icons.star,
    Icons.check_circle,
    Icons.alarm,
  ];

  // stats
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TypeTaskProvider>().loadTasks();
    });
  }

  //  DIALOG
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
                          setStateDialog(() {
                            _selectedIcon = icon;
                          });
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
                          setStateDialog(() {
                            _selectedColor = color;
                          });
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

                // BOTÓN
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypeTaskProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Text(
                'Panel Profesional',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    sectionTile(
                      icon: Icons.checklist_rtl,
                      color: Colors.lightGreen,
                      title: "Tipo de Tareas",
                      subtitle: "Tareas creadas",
                      items:
                          provider.tasks.map((t) => t.title).toList(),
                      onAdd: _openAddTaskDialog,
                    ),

                    sectionTile(
                      icon: Icons.auto_awesome_mosaic,
                      color: const Color.fromARGB(255, 146, 146, 199),
                      title: "Grupo de Tareas",
                      subtitle: "Lista de grupos",
                      items: ["Grupo 1", "Grupo 2", "Grupo 3"],
                    ),

                    sectionTile(
                      icon: Icons.contact_support,
                      color: Colors.amber,
                      title: "Guía de Ayuda",
                      subtitle: "Pasos de ayuda",
                      items: ["Paso 1", "Paso 2", "Paso 3"],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}