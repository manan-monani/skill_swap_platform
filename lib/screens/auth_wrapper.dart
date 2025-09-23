import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/screens/auth/login_screen.dart';
import 'package:skill_swap_platform/screens/home/home_screen.dart';

// This widget acts as a wrapper to decide which screen to show based on the authentication state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AuthProvider from the widget tree.
    final authProvider = Provider.of<AuthProvider>(context);

    // If the user is logged in, show the home screen.
    if (authProvider.user != null) {
      return const HomeScreen();
    } 
    // Otherwise, show the login screen.
    else {
      return const LoginScreen();
    }
  }
}
