// This file contains validation functions for text fields.

class Validators {
  // Validate email format.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate password length.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Validate if a field is not empty.
  static String? notEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }
}
