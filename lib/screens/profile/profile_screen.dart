import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/screens/profile/edit_profile_screen.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';
import 'package:skill_swap_platform/widgets/rating_widget.dart';
import 'package:skill_swap_platform/widgets/user_avatar.dart';

// The profile screen, which displays the user's profile information.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.userModel;

        if (user == null) {
          // If user data is still loading, show a loading widget.
          return const LoadingWidget();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              // Center the content horizontally.
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pass the profile picture URL to the UserAvatar widget.
                  UserAvatar(radius: 60, imageUrl: user.profilePictureUrl),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.bio ?? 'No bio available. Add one!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'My Skills',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Display a message if the user has no skills.
                  if (user.skills.isEmpty)
                    const Text('No skills added yet.')
                  else
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: user.skills
                          .map((skill) => Chip(label: Text(skill)))
                          .toList(),
                    ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Ratings & Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Placeholder for ratings.
                  const RatingWidget(rating: 4.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
