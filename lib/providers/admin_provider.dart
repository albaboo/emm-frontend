import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../models/user_model.dart';

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

  Future<void> createUser(Map<String, dynamic> body) async {
    final newUser = await adminService.add(body);

    users.add(newUser);
    await loadUsers();
    notifyListeners();
  }

  List<User> get medicals =>
      users.where((u) => u.type.value == 'MEDICAL').toList();

  List<User> get patients =>
      users.where((u) => u.type.value == 'PATIENT').toList();

  List<User> get carers =>
      users.where((u) => u.type.value == 'CARER').toList();
}