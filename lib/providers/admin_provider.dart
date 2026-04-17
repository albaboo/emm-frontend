import 'package:emm_app/models/patient_model.dart';
import 'package:flutter/material.dart';

import '../models/carer_model.dart';
import '../models/medical_model.dart';
import '../models/user_model.dart';
import '../services/admin_service.dart';

class AdminProvider extends ChangeNotifier {
  final AdminService adminService;

  AdminProvider(this.adminService);

  List<User> users = [];
  bool loading = false;

  Future<void> loadUsers() async {
    loading = true;
    notifyListeners();

    users = await adminService.list();

    loading = false;
    notifyListeners();
  }

  Future<User> getUser(int id) async {
    return await adminService.get(id);
  }

  Future<void> createUser(Map<String, dynamic> body) async {
    final newUser = await adminService.add(body);

    users.add(newUser);
    await loadUsers();
    notifyListeners();
  }

  Future<void> updateUser(int id, Map<String, dynamic> body) async {
    final updated = await adminService.update(id, body);

    final index = users.indexWhere((u) => u.id == id);
    if (index != -1) users[index] = updated;

    await loadUsers();
    notifyListeners();
  }

  List<Medical> get medicals =>
      users.where((u) => u.type.value == 'MEDICAL').toList().cast<Medical>();

  List<Patient> get patients =>
      users.where((u) => u.type.value == 'PATIENT').toList().cast<Patient>();

  List<Carer> get carers =>
      users.where((u) => u.type.value == 'CARER').toList().cast<Carer>();
}
