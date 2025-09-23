import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/screens/auth/register_screen.dart';
import 'package:skill_swap_platform/utils/helpers.dart';
import 'package:skill_swap_platform/utils/validators.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';

// The login screen for the skill_swap_platform application.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A global key for the form.
  final _formKey = GlobalKey<FormState>();
  // Controllers for the email and password text fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function to handle the login process.
  void _login() async {
    // Validate the form fields.
    if (_formKey.currentState!.validate()) {
      // Access the AuthProvider.
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        // Attempt to sign in.
        await authProvider.signIn(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        // Show an error message if login fails.
        Helpers.showSnackBar(context, 'Failed to sign in: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('skill_swap_platform Platform')),
      // Use a Consumer to listen for changes in the AuthProvider.
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // If the app is in a loading state, show the loading widget.
          if (authProvider.isLoading) {
            return const LoadingWidget();
          }
          // Otherwise, show the login form.
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // The email text field with validation.
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  // The password text field with validation.
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 24),
                  // The login button.
                  CustomButton(text: 'Login', onPressed: _login),
                  // The "Forgot your password?" text button.
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot your password?'),
                  ),
                  // The "Don't have an account?" text button to navigate to the register screen.
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
