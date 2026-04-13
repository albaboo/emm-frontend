import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'screens/login/user_screen.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
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
      home: const UserScreen(),
    );
  }
}
