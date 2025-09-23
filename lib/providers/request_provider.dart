import 'package:flutter/material.dart';
import 'package:skill_swap_platform/models/request_model.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';

// This provider manages the skill swap requests in the application.
class RequestProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  // Get a stream of incoming requests for a user.
  Stream<List<RequestModel>> getIncomingRequests(String userId) {
    return _firestoreService.getIncomingRequests(userId);
  }

  // Get a stream of outgoing requests for a user.
  Stream<List<RequestModel>> getOutgoingRequests(String userId) {
    return _firestoreService.getOutgoingRequests(userId);
  }

  // Add a new request.
  Future<void> addRequest(RequestModel request) async {
    await _firestoreService.addRequest(request);
    notifyListeners();
  }
  
  // Update the status of a request.
  Future<void> updateRequestStatus(String requestId, String status) async {
    await _firestoreService.updateRequestStatus(requestId, status);
    notifyListeners();
  }
}

