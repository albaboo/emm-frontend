import 'package:emm_app/features/admin/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/user_types.dart';
import '../../core/session/session_actions.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/create_user_dialog.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  UserType? selectedFilter;

  static const double _mobileBreakpoint = 760;
  static const double _tabletBreakpoint = 1100;

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

  String _hospitalName(BuildContext context) {
    final rawName = context.watch<UserProvider>().user?.hospital?.name;
    final name = rawName?.trim();
    return (name == null || name.isEmpty) ? 'Sin hospital' : name;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminProvider>();
    final filteredUsers = usersFiltered(provider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < _mobileBreakpoint;
    final isTablet =
        screenWidth >= _mobileBreakpoint && screenWidth < _tabletBreakpoint;
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 100.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      appBar: isMobile
          ? _buildMobileAppBar(context)
          : _buildDesktopAppBar(context),

      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: isMobile ? 12 : 20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final spacing = isMobile ? 10.0 : 20.0;
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
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => setState(
                                () => selectedFilter = UserType.patient,
                              ),
                              child: _Stat(
                                "Pacientes",
                                provider.patients.length,
                                icon: Icons.favorite_outline,
                                iconColor: Colors.purple,
                                isSelected: selectedFilter == UserType.patient,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => setState(
                                () => selectedFilter = UserType.carer,
                              ),
                              child: _Stat(
                                "Cuidadores",
                                provider.carers.length,
                                icon: Icons.diversity_1,
                                iconColor: Colors.green,
                                isSelected: selectedFilter == UserType.carer,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => setState(
                                () => selectedFilter = UserType.medical,
                              ),
                              child: _Stat(
                                "Médicos",
                                provider.medicals.length,
                                icon: Icons.medical_services,
                                iconColor: const Color.fromARGB(
                                  255,
                                  176,
                                  39,
                                  48,
                                ),
                                isSelected: selectedFilter == UserType.medical,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () =>
                                  setState(() => selectedFilter = null),
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
                      );
                    },
                  ),
                ),

                SizedBox(height: isMobile ? 12 : 20),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final u = filteredUsers[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 6 : 10,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(isMobile ? 14 : 18),
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
                            child: isMobile
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          _buildUserIcon(
                                            u.type.value,
                                            size: 58,
                                            iconSize: 28,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              '${u.name ?? ''} ${u.lastnames ?? ''}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1D2A3A),
                                              ),
                                            ),
                                          ),
                                          _buildEditButton(context, u.id),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        u.email ?? u.phone ?? '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF4A5568),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      _buildUserIcon(u.type.value),
                                      const SizedBox(width: 16),
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
                                      _buildEditButton(context, u.id),
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

  AppBar _buildDesktopAppBar(BuildContext context) {
    final hospitalName = _hospitalName(context);

    return AppBar(
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Panel Hospital", style: TextStyle(fontSize: 25)),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  hospitalName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const Text("Gestión de usuarios", style: TextStyle(fontSize: 16)),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Center(child: _buildCreateUserButton(context)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(child: _buildLogoutButton(context)),
        ),
      ],
    );
  }

  AppBar _buildMobileAppBar(BuildContext context) {
    final hospitalName = _hospitalName(context);

    return AppBar(
      toolbarHeight: 132,
      titleSpacing: 12,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Panel Hospital", style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  hospitalName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const Text("Gestión de usuarios", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildCreateUserButton(context, compact: true)),
              const SizedBox(width: 8),
              _buildLogoutButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateUserButton(BuildContext context, {bool compact = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        showDialog(context: context, builder: (_) => const CreateUserDialog());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 16,
          vertical: compact ? 8 : 10,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: compact ? 18 : 20),
            SizedBox(width: compact ? 6 : 8),
            Text(
              "Añadir usuario",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: compact ? 13 : 14,
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildUserIcon(String type, {double size = 70, double iconSize = 35}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(_icon(type), size: iconSize, color: _iconColor(type)),
    );
  }

  Widget _buildEditButton(BuildContext context, int userId) {
    return IconButton(
      icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 30),
      tooltip: "Editar",
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => EditUserDialog(userId: userId),
        );
      },
    );
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
