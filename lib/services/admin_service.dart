import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../factories/user_factory.dart';
import '../models/user_model.dart';

class AdminService {
  final Dio dio = DioClient.dio;

  /// GET /users
  Future<List<User>> list() async {
    try {
      final response = await dio.get('/users');

      final data = response.data as List;

      return data
          .map((u) => UserFactory.fromJson(u))
          .toList();
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error al obtener usuarios';
      throw Exception(msg);
    }
  }

  /// POST /users
  Future<User> add(Map<String, dynamic> body) async {
    try {
      final response = await dio.post(
        '/users',
        data: body,
      );

      return UserFactory.fromJson(response.data['user']);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error al crear usuario';
      throw Exception(msg);
    }
  }
}