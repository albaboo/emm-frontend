import 'package:emm_app/core/navigation/app_navigator.dart';
import 'package:emm_app/core/network/dio_client.dart';
import 'package:emm_app/providers/admin_provider.dart';
import 'package:emm_app/services/admin_service.dart';
import 'package:emm_app/services/type_task_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'features/login/user_screen.dart';
import 'providers/user_provider.dart';
import 'package:emm_app/providers/type_task_provider.dart';


void main() {
  final userProvider = UserProvider();

  DioClient.setUnauthorizedHandler(() {
    userProvider.logout();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ChangeNotifierProvider(create: (_) => AdminProvider(AdminService())),
        ChangeNotifierProvider(create: (_) => TypeTaskProvider(TypeTaskService())),
      ],
      child: const EmmApp(),
    ),
  );
}

class EmmApp extends StatelessWidget {
  const EmmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      // title: 'EMM',
      debugShowCheckedModeBanner: false,
     home: const UserScreen(),
  
    );
  }
}
