import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../models/typetask_model.dart';

class TypeTaskService {
  final Dio dio = DioClient.dio;

  /// GET /type-tasks
  Future<List<TypeTask>> list() async {
    try {
      final response = await dio.get('/type-tasks');

      final data = response.data as List;

      return data
          .map((t) => TypeTask.fromJson(t))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data?['message'] ?? 'Error al obtener tareas';
      throw Exception(msg);
    }
  }

  /// POST /type-tasks
  Future<TypeTask> add(Map<String, dynamic> body) async {
    try {
      final response = await dio.post(
        '/type-tasks',
        data: body,
      );

      return TypeTask.fromJson(response.data);
    } on DioException catch (e) {
      final msg =
          e.response?.data?['message'] ?? 'Error al crear tarea';
      throw Exception(msg);
    }
  }
}