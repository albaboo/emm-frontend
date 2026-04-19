import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emm_app/core/session/session_actions.dart';

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

  static const double _mobileBreakpoint = 760;
  static const double _tabletBreakpoint = 1100;

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
                      color: _selectedColor.toARGB32().toString(),
                    );

                    await context.read<TypeTaskProvider>().createTask(
                      task.toJson(),
                    );

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < _mobileBreakpoint;
    final isTablet =
        screenWidth >= _mobileBreakpoint && screenWidth < _tabletBreakpoint;
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 25.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: _buildAppBar(context),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: isMobile ? 12 : 20),

              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = isMobile ? 10.0 : 15.0;
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : isTablet
                      ? (constraints.maxWidth - spacing) / 2
                      : (constraints.maxWidth - (spacing * 3)) / 4;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _Stat(
                          "Configuracion",
                          provider.tasks.length,
                          icon: Icons.settings,
                          iconColor: Colors.lightGreen,
                          isSelected: true,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _Stat(
                          "Pacientes",
                          _icons.length,
                          icon: Icons.account_box,
                          iconColor: Colors.purple,
                          isSelected: false,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _Stat(
                          "Alertas Activas",
                          _colors.length,
                          icon: Icons.add_alert,
                          iconColor: Colors.orange,
                          isSelected: false,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _Stat(
                          "Tareas Hoy",
                          provider.tasks.length,
                          icon: Icons.access_time,
                          iconColor: Colors.blueGrey,
                          isSelected: false,
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: isMobile ? 12 : 20),

              // list
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return sectionTile(
                        context: context,
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
                        context: context,
                        icon: Icons.auto_awesome_mosaic,
                        color: const Color(0xFFA7A6F2),
                        title: "Grupo de Tareas",
                        subtitle: "Lista de grupos",
                        items: ["Grupo 1", "Grupo 2", "Grupo 3"],
                      );
                    }

                    return sectionTile(
                      context: context,
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Panel Profesional", style: TextStyle(fontSize: 25))],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: _buildLogoutButton(context)),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return IconButton(
      tooltip: 'Cerrar sesion',
      onPressed: () =>
          SessionActions.logout(context, message: 'Sesion cerrada'),
      icon: const Icon(Icons.logout),
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
    final isNarrow = MediaQuery.of(context).size.width < 760;

    return Container(
      padding: EdgeInsets.all(isNarrow ? 14 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? iconColor : iconColor.withValues(alpha: 0.3),
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
                style: TextStyle(
                  fontSize: isNarrow ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: isNarrow ? 20 : 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D2A3A),
                ),
              ),
            ],
          ),

          // ICONO DERECHA
          Container(
            width: isNarrow ? 36 : 42,
            height: isNarrow ? 36 : 42,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: isNarrow ? 28 : 32),
          ),
        ],
      ),
    );
  }
}
