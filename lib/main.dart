import 'package:flutter/material.dart';
import 'package:skill_swap_platform/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/providers/request_provider.dart';
import 'package:skill_swap_platform/providers/skill_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// The main entry point of the application.
void main() async {
  // Ensure that the Flutter widgets framework is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Run the app.
  runApp(
    // Use MultiProvider to provide multiple providers to the widget tree.
    MultiProvider(
      providers: [
        // Provide the AuthProvider.
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Provide the SkillProvider.
        ChangeNotifierProvider(create: (_) => SkillProvider()),
        // Provide the RequestProvider.
        ChangeNotifierProvider(create: (_) => RequestProvider()),
      ],
      // The root widget of the application.
      child: const skill_swap_platformApp(),
    ),
  );
}
