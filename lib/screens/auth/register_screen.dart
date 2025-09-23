import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/utils/helpers.dart';
import 'package:skill_swap_platform/utils/validators.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';

// The register screen for the skill_swap_platform application.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // A global key for the form.
  final _formKey = GlobalKey<FormState>();
  // Controllers for the name, email, and password text fields.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function to handle the registration process.
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        );
        // Navigate back to the previous screen on successful registration.
        Navigator.of(context).pop();
      } catch (e) {
        Helpers.showSnackBar(context, 'Failed to register: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      // Use a Consumer to listen for changes in the AuthProvider.
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const LoadingWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // The name text field with validation.
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) => Validators.notEmpty(value, 'Name'),
                  ),
                  const SizedBox(height: 16),
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
                  // The register button.
                  CustomButton(
                    text: 'Register',
                    onPressed: _register,
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

