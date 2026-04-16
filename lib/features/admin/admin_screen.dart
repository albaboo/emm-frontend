import 'package:emm_app/features/admin/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/user_types.dart';
import '../../providers/admin_provider.dart';
import 'widgets/create_user_dialog.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  UserType? selectedFilter;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AdminProvider>().loadUsers();
    });
  }

  List usersFiltered(AdminProvider provider) {
    if (selectedFilter == null) return provider.users;

    return provider.users.where((u) => u.type == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminProvider>();

    final filteredUsers = usersFiltered(provider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),

      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Panel Hospital", style: TextStyle(fontSize: 25)),
            Text("Gestión de usuarios", style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const CreateUserDialog(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Añadir usuario",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),

                // STATS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              selectedFilter = UserType.patient;
                            });
                          },
                          child: _Stat(
                            "Pacientes",
                            provider.patients.length,
                            icon: Icons.favorite_outline,
                            iconColor: Colors.purple,
                            isSelected: selectedFilter == UserType.patient,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              selectedFilter = UserType.carer;
                            });
                          },
                          child: _Stat(
                            "Cuidadores",
                            provider.carers.length,
                            icon: Icons.diversity_1,
                            iconColor: Colors.green,
                            isSelected: selectedFilter == UserType.carer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              selectedFilter = UserType.medical;
                            });
                          },
                          child: _Stat(
                            "Médicos",
                            provider.medicals.length,
                            icon: Icons.medical_services,
                            iconColor: const Color.fromARGB(255, 176, 39, 48),
                            isSelected: selectedFilter == UserType.medical,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              selectedFilter = null;
                            });
                          },
                          child: _Stat(
                            "Todos",
                            provider.users.length,
                            icon: Icons.people,
                            iconColor: Colors.blueGrey,
                            isSelected: selectedFilter == null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // LISTA
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final u = filteredUsers[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: _backgroundColor(u.type.value),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: _borderColor(u.type.value),
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // ICONO
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _icon(u.type.value),
                                    size: 35,
                                    color: _iconColor(u.type.value),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${u.name ?? ''} ${u.lastnames ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1D2A3A),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        u.email ?? u.phone ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF4A5568),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 32),
                                  tooltip: "Editar",
                                  onPressed: () {
                                    showDialog(
                                      context: context,

                                      builder: (_) => EditUserDialog(userId: u.id),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  IconData _icon(String type) {
    switch (type) {
      case 'MEDICAL':
        return Icons.medical_services;
      case 'PATIENT':
        return Icons.favorite_outline;
      case 'CARER':
        return Icons.diversity_1;
      default:
        return Icons.apartment;
    }
  }

  Color _backgroundColor(String type) {
    switch (type) {
      case 'MEDICAL':
        return const Color(0xFFF0E2FF);
      case 'PATIENT':
        return const Color(0xFFE8DDFF);
      case 'CARER':
        return const Color(0xFFD9F7E4);
      default:
        return const Color(0xFFDDF6FB);
    }
  }

  Color _borderColor(String type) {
    switch (type) {
      case 'MEDICAL':
        return const Color.fromARGB(255, 222, 145, 145);
      case 'PATIENT':
        return const Color(0xFFA87CFF);
      case 'CARER':
        return const Color(0xFF63D98A);
      default:
        return const Color(0xFF48D3F2);
    }
  }

  Color _iconColor(String type) {
    switch (type) {
      case 'MEDICAL':
        return const Color.fromARGB(255, 176, 39, 48);
      case 'PATIENT':
        return Colors.purple;
      case 'CARER':
        return Colors.green;
      default:
        return Colors.cyan;
    }
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
