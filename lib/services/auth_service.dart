import 'package:dio/dio.dart';
import 'package:emm_app/core/enums/user_types.dart';

import '../core/network/dio_client.dart';

class AuthService {
  final Dio dio = DioClient.dio;

  Future<Map<String, dynamic>> login(
    String username,
    String password,
    UserType type,
  ) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'username': username, 'password': password, 'type': type.value},
      );

      return response.data;
    } on DioException catch (e) {
      final data = e.response?.data;

      print('STATUS: ${e.response?.statusCode}');
      print('DATA: $data');
      print("RESPONSE: ${e}");

      String message = 'Inicio de sesión fallido';

      if (data is Map<String, dynamic>) {
        message = data['message'] ??
            data['error'] ??
            data['errors']?.toString() ??
            message;
      }

      throw Exception(message);
    }
  }
}
