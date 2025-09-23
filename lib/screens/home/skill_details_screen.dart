import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/models/user_model.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/screens/requests/create_request_screen.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/user_avatar.dart';

// This screen displays the details of a specific skill.
class SkillDetailsScreen extends StatelessWidget {
  final SkillModel skill;

  const SkillDetailsScreen({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID.
    final currentUserId = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).user?.uid;
    // Instantiate FirestoreService to fetch user data.
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: Text(skill.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use a FutureBuilder to get the skill owner's user data.
            FutureBuilder<UserModel?>(
              future: firestoreService.getUser(skill.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Text('Could not load user data.');
                }
                final user = snapshot.data!;
                return Row(
                  children: [
                    UserAvatar(imageUrl: user.profilePictureUrl),
                    const SizedBox(width: 12),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Category: ${skill.category}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(skill.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            // Only show the "Request Swap" button if the viewer is not the owner of the skill.
            if (currentUserId != skill.userId)
              CustomButton(
                text: 'Request Skill Swap',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateRequestScreen(skillToRequest: skill),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
