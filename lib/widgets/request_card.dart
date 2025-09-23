import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/request_model.dart';
import 'package:skill_swap_platform/providers/request_provider.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';

// A widget to display a single request in a card format.
class RequestCard extends StatelessWidget {
  final RequestModel request;
  final bool isIncoming; // Determines if the request is incoming or outgoing.

  const RequestCard({super.key, required this.request, this.isIncoming = false});
  
  // A helper function to get a status color.
  Color _getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'declined':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    final requestProvider = Provider.of<RequestProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use FutureBuilders to get and display user and skill names.
            // This is a simplified version; a more robust solution might use a dedicated provider or model that pre-fetches this data.
            FutureBuilder(
              future: Future.wait([
                firestoreService.getUser(isIncoming ? request.fromUserId : request.toUserId),
                firestoreService.getSkill(request.skillRequestedId),
                firestoreService.getSkill(request.skillOfferedId),
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading details...');
                }
                if (!snapshot.hasData) {
                  return const Text('Could not load details.');
                }
                final user = snapshot.data![0];
                final requestedSkill = snapshot.data![1];
                final offeredSkill = snapshot.data![2];

                return Text(
                  isIncoming
                      ? '${user.name} wants to swap their ${offeredSkill.name} for your ${requestedSkill.name}.'
                      : 'You requested to swap your ${offeredSkill.name} for ${user.name}\'s ${requestedSkill.name}.',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    request.status.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(request.status),
                ),
                // If the request is incoming and pending, show Accept/Decline buttons.
                if (isIncoming && request.status == 'pending')
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () => requestProvider.updateRequestStatus(request.id, 'accepted'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => requestProvider.updateRequestStatus(request.id, 'declined'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
