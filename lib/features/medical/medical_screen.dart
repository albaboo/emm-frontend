import 'package:emm_app/core/session/session_actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/carer_model.dart';
import '../../models/patient_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/carers_management_screen.dart';
import 'widgets/patients_management_screen.dart';
import 'widgets/settings_management_screen.dart';

enum MedicalSection { configuration, patients, carers }

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  static const double _mobileBreakpoint = 760;
  static const double _tabletBreakpoint = 1100;

  MedicalSection _selectedSection = MedicalSection.configuration;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AdminProvider>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();
    final currentHospitalId = context.watch<UserProvider>().user?.hospital?.id;

    final patients = _filterPatientsByHospital(
      adminProvider.patients,
      currentHospitalId,
    );
    final carers = _filterCarersByHospital(
      adminProvider.carers,
      currentHospitalId,
    );

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
                      : (constraints.maxWidth - (spacing * 2)) / 3;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(
                            () =>
                                _selectedSection = MedicalSection.configuration,
                          ),
                          child: _Stat(
                            "Configuración",
                            icon: Icons.settings,
                            iconColor: Colors.blueGrey,
                            isSelected:
                                _selectedSection ==
                                MedicalSection.configuration,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(
                            () => _selectedSection = MedicalSection.patients,
                          ),
                          child: _Stat(
                            "Pacientes",
                            icon: Icons.favorite_border,
                            iconColor: Colors.purple,
                            isSelected:
                                _selectedSection == MedicalSection.patients,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(
                            () => _selectedSection = MedicalSection.carers,
                          ),
                          child: _Stat(
                            "Cuidadores",
                            icon: Icons.diversity_1,
                            iconColor: Colors.green,
                            isSelected:
                                _selectedSection == MedicalSection.carers,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: isMobile ? 12 : 20),
              Expanded(
                child: _buildSelectedSection(
                  section: _selectedSection,
                  patients: patients,
                  carers: carers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Patient> _filterPatientsByHospital(List<Patient> list, int? hospitalId) {
    if (hospitalId == null) {
      return list;
    }

    return list.where((patient) => patient.hospital?.id == hospitalId).toList();
  }

  List<Carer> _filterCarersByHospital(List<Carer> list, int? hospitalId) {
    if (hospitalId == null) {
      return list;
    }

    return list.where((carer) => carer.hospital?.id == hospitalId).toList();
  }

  Widget _buildSelectedSection({
    required MedicalSection section,
    required List<Patient> patients,
    required List<Carer> carers,
  }) {
    switch (section) {
      case MedicalSection.configuration:
        return const SettingsManagementScreen();
      case MedicalSection.patients:
        return PatientsManagementScreen(patients: patients);
      case MedicalSection.carers:
        return CarersManagementScreen(carers: carers);
    }
  }

  String _hospitalName(BuildContext context) {
    final rawName = context.watch<UserProvider>().user?.hospital?.name;
    final name = rawName?.trim();
    return (name == null || name.isEmpty) ? 'Sin hospital' : name;
  }

  AppBar _buildAppBar(BuildContext context) {
    final hospitalName = _hospitalName(context);

    return AppBar(
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Panel Profesional", style: TextStyle(fontSize: 25)),
          const SizedBox(height: 2),
          Text(
            hospitalName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: IconButton(
              tooltip: 'Cerrar sesion',
              onPressed: () =>
                  SessionActions.logout(context, message: 'Sesion cerrada'),
              icon: const Icon(Icons.logout),
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;

  const _Stat(
    this.label, {
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
