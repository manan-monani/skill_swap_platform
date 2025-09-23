import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/request_model.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/providers/request_provider.dart';
import 'package:skill_swap_platform/providers/skill_provider.dart';
import 'package:skill_swap_platform/utils/helpers.dart';
import 'package:skill_swap_platform/widgets/common/custom_button.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';
import 'package:uuid/uuid.dart';

// This screen allows a user to create a new skill swap request.
class CreateRequestScreen extends StatefulWidget {
  final SkillModel skillToRequest;

  const CreateRequestScreen({super.key, required this.skillToRequest});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  // The ID of the skill the user is offering.
  String? _selectedSkillId;

  // Function to send the skill swap request.
  void _sendRequest() async {
    if (_selectedSkillId == null) {
      Helpers.showSnackBar(context, 'Please select a skill to offer.');
      return;
    }

    final requestProvider = Provider.of<RequestProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Create a new request model.
    final newRequest = RequestModel(
      id: const Uuid().v4(),
      fromUserId: authProvider.user!.uid,
      toUserId: widget.skillToRequest.userId,
      skillRequestedId: widget.skillToRequest.id,
      skillOfferedId: _selectedSkillId!,
      status: 'pending',
      timestamp: DateTime.now(),
    );

    try {
      await requestProvider.addRequest(newRequest);
      Helpers.showSnackBar(context, 'Request sent successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      Helpers.showSnackBar(context, 'Failed to send request: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final skillProvider = Provider.of<SkillProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You are requesting:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text(widget.skillToRequest.name),
                subtitle: Text(widget.skillToRequest.category),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Offer one of your skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Use a StreamBuilder to display the current user's skills.
            StreamBuilder<List<SkillModel>>(
              stream: skillProvider.skills,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('You have no skills to offer.');
                }

                // Filter the skills to only show the ones owned by the current user.
                final mySkills = snapshot.data!
                    .where((skill) => skill.userId == authProvider.user!.uid)
                    .toList();

                if (mySkills.isEmpty) {
                  return const Center(
                    child: Text("You haven't added any skills to offer yet."),
                  );
                }

                // A dropdown button to select a skill to offer.
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select your skill',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSkillId,
                  items: mySkills.map((skill) {
                    return DropdownMenuItem(
                      value: skill.id,
                      child: Text(skill.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSkillId = value;
                    });
                  },
                );
              },
            ),
            const Spacer(),
            CustomButton(text: 'Send Request', onPressed: _sendRequest),
          ],
        ),
      ),
    );
  }
}
