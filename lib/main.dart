import 'package:emm_app/features/admin/admin_screen.dart';
import 'package:emm_app/features/medical/widgets/form_screen.dart';
import 'package:emm_app/providers/admin_provider.dart';
import 'package:emm_app/services/admin_service.dart';
import 'package:emm_app/services/typetask_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'features/login/user_screen.dart';
import 'providers/user_provider.dart';
import 'providers/typetask_provider.dart';
import '';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),

      ChangeNotifierProvider(create: (_) => AdminProvider(AdminService())),

      ChangeNotifierProvider(create: (_) => TypeTaskProvider(TypeTaskService()),
      ),
    ],
    child: const EmmApp(),
  ),
);

class EmmApp extends StatelessWidget {
  const EmmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'EMM',
      debugShowCheckedModeBanner: false,
    // home: const UserScreen(),
   home : FormScreen(),
    );
  }
}
