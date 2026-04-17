import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../services/storage_service.dart';
import '../navigation/app_navigator.dart';

class SessionActions {
  static Future<void> logout(BuildContext context, {String? message}) async {
    final userProvider = context.read<UserProvider>();

    await StorageService.deleteToken();
    userProvider.logout();

    AppNavigator.goToLogin(message: message);
  }
}

