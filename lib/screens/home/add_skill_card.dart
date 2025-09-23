import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/providers/skill_provider.dart';
import 'package:skill_swap_platform/utils/helpers.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/common/custom_text_field.dart';
import 'package:uuid/uuid.dart';

// The screen for adding a new skill.
class AddSkillScreen extends StatefulWidget {
  const AddSkillScreen({super.key});

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  // A global key for the form.
  final _formKey = GlobalKey<FormState>();
  // Controllers for the skill name, description, and category text fields.
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  // Function to handle adding a new skill.
  void _addSkill() async {
    if (_formKey.currentState!.validate()) {
      // Get the providers.
      final skillProvider = Provider.of<SkillProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // A unique ID for the new skill.
      const uuid = Uuid();
      final skillId = uuid.v4();

      // The current user's ID.
      final userId = authProvider.user!.uid;

      // Create a new SkillModel instance.
      final newSkill = SkillModel(
        id: skillId,
        name: _nameController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        userId: userId,
      );

      try {
        // Add the new skill using the SkillProvider.
        await skillProvider.addSkill(newSkill);
        Helpers.showSnackBar(context, 'Skill added successfully!');
        // Go back to the previous screen.
        Navigator.of(context).pop();
      } catch (e) {
        Helpers.showSnackBar(context, 'Failed to add skill: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Skill')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // The skill name text field.
              CustomTextField(
                controller: _nameController,
                labelText: 'Skill Name',
              ),
              const SizedBox(height: 16),
              // The skill description text field.
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              // The skill category text field.
              CustomTextField(
                controller: _categoryController,
                labelText: 'Category (e.g., Programming, Music)',
              ),
              const Spacer(),
              // The button to add the skill.
              CustomButton(text: 'Add Skill', onPressed: _addSkill),
            ],
          ),
        ),
      ),
    );
  }
}
