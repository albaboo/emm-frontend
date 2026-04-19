import 'package:flutter/material.dart';

import '../models/type_task_model.dart';
import '../services/type_task_service.dart';

class TypeTaskProvider extends ChangeNotifier {
  final TypeTaskService typeTaskService;

  TypeTaskProvider(this.typeTaskService);

  List<TypeTask> tasks = [];
  bool loading = false;

  Future<void> loadTasks() async {
    loading = true;
    notifyListeners();

    tasks = await typeTaskService.list();

    loading = false;
    notifyListeners();
  }

  Future<void> createTask(Map<String, dynamic> body) async {
    final newTask = await typeTaskService.add(body);

    tasks.add(newTask);
    await loadTasks();
    notifyListeners();
  }
}