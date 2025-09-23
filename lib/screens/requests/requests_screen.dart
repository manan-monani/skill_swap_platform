import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/request_model.dart';
import 'package:skill_swap_platform/providers/auth_provider.dart';
import 'package:skill_swap_platform/providers/request_provider.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';
import 'package:skill_swap_platform/widgets/request_card.dart';

// This screen displays the user's incoming and outgoing skill swap requests.
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    final userId = authProvider.user!.uid;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(text: 'Incoming'),
            Tab(text: 'Outgoing'),
          ],
        ),
        body: TabBarView(
          children: [
            // Incoming requests tab.
            StreamBuilder<List<RequestModel>>(
              stream: requestProvider.getIncomingRequests(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No incoming requests.'));
                }
                final requests = snapshot.data!;
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return RequestCard(
                      request: requests[index],
                      isIncoming: true,
                    );
                  },
                );
              },
            ),
            // Outgoing requests tab.
            StreamBuilder<List<RequestModel>>(
              stream: requestProvider.getOutgoingRequests(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No outgoing requests.'));
                }
                final requests = snapshot.data!;
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return RequestCard(request: requests[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
