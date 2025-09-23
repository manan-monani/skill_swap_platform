import 'package:cloud_firestore/cloud_firestore.dart';

// This model represents a skill swap request.
class RequestModel {
  final String id;
  final String fromUserId; // The user who sent the request.
  final String toUserId; // The user who received the request.
  final String skillRequestedId;
  final String skillOfferedId;
  final String status; // e.g., 'pending', 'accepted', 'declined'
  final DateTime timestamp;

  RequestModel({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.skillRequestedId,
    required this.skillOfferedId,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'skillRequestedId': skillRequestedId,
      'skillOfferedId': skillOfferedId,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'],
      fromUserId: map['fromUserId'],
      toUserId: map['toUserId'],
      skillRequestedId: map['skillRequestedId'],
      skillOfferedId: map['skillOfferedId'],
      status: map['status'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}

