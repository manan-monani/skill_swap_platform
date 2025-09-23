import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/utils/helpers.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/common/custom_text_field.dart';
import 'package:skill_swap_platform/widgets/user_avatar.dart';

// The edit profile screen, which allows users to update their profile information.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // A file to hold the selected profile image.
  File? _profileImage;
  // Controllers for the name and bio text fields, initialized when the widget is built.
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize controllers here to access the provider.
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _nameController = TextEditingController(
      text: authProvider.userModel?.name ?? '',
    );
    _bioController = TextEditingController(
      text: authProvider.userModel?.bio ?? '',
    );
  }

  // Function to pick an image from the gallery.
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to save the profile changes.
  void _saveProfile() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Helpers.showLoadingDialog(context);
    try {
      await authProvider.updateUserProfile(
        name: _nameController.text,
        bio: _bioController.text,
        image: _profileImage,
      );
      // Pop the loading dialog and the edit screen.
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Helpers.showSnackBar(context, 'Profile updated successfully!');
    } catch (e) {
      Navigator.of(context).pop();
      Helpers.showSnackBar(
        context,
        'Failed to update profile: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the AuthProvider to get the current user's data.
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.userModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                // Display the selected image or the current profile picture.
                _profileImage != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(_profileImage!),
                      )
                    : UserAvatar(radius: 60, imageUrl: user?.profilePictureUrl),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomTextField(controller: _nameController, labelText: 'Name'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _bioController,
              labelText: 'Bio',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            CustomButton(text: 'Save Changes', onPressed: _saveProfile),
          ],
        ),
      ),
    );
  }
}
