import 'package:flutter/material.dart';

// This file defines the theme for the skill_swap_platform application.
class AppTheme {
  // The light theme for the application.
  static final ThemeData lightTheme = ThemeData(
    // The primary color of the application.
    primarySwatch: Colors.blue,
    // The visual density of the application.
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // The app bar theme.
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    // The floating action button theme.
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    // The button theme.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    // The input decoration theme for text fields.
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
  );
}
