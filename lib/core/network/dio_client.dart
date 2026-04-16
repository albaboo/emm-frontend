import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../navigation/app_navigator.dart';

class DioClient {
  static VoidCallback? _onUnauthorized;
  static bool _isHandlingUnauthorized = false;

  static void setUnauthorizedHandler(VoidCallback handler) {
    _onUnauthorized = handler;
  }

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:80/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && !_isHandlingUnauthorized) {
            _isHandlingUnauthorized = true;

            try {
              await StorageService.deleteToken();
              _onUnauthorized?.call();
              AppNavigator.goToLogin(message: 'Sesion expirada');
            } finally {
              _isHandlingUnauthorized = false;
            }
          }

          return handler.next(error);
        },
      ),
    );
}