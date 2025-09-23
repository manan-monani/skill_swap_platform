import 'package:flutter/material.dart';
import 'package:skill_swap_platform/screens/auth_wrapper.dart';
import 'package:skill_swap_platform/theme/app_theme.dart';

// The root widget of the skill_swap_platform application.
class skill_swap_platformApp extends StatelessWidget {
  const skill_swap_platformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The title of the application.
      title: 'skill_swap_platform',
      // The theme of the application.
      theme: AppTheme.lightTheme,
      // The initial screen of the application is now the AuthWrapper.
      home: const AuthWrapper(),
      // Hide the debug banner.
      debugShowCheckedModeBanner: false,
    );
  }
}
