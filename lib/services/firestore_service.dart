import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skill_swap_platform/models/user_model.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/models/request_model.dart';
import 'package:skill_swap_platform/models/rating_model.dart';

// This service handles all interactions with Cloud Firestore.
class FirestoreService {

  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');
  final CollectionReference _skillsCollection = FirebaseFirestore.instance
      .collection('skills');
  final CollectionReference _requestsCollection = FirebaseFirestore.instance
      .collection('requests');
  final CollectionReference _ratingsCollection = FirebaseFirestore.instance
      .collection('ratings');

  // --- User Methods ---

  Future<void> createUser(UserModel user) async {
    return await _usersCollection.doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot doc = await _usersCollection.doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    return await _usersCollection.doc(uid).update(data);
  }

  // --- Skill Methods ---

  Future<void> addSkill(SkillModel skill) async {
    await _skillsCollection.doc(skill.id).set(skill.toMap());
  }

  // Get a single skill document from Firestore.
  Future<SkillModel?> getSkill(String id) async {
    DocumentSnapshot doc = await _skillsCollection.doc(id).get();
    if (doc.exists) {
      return SkillModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<SkillModel>> getSkills() {
    return _skillsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => SkillModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // --- Request Methods ---

  Future<void> addRequest(RequestModel request) async {
    await _requestsCollection.doc(request.id).set(request.toMap());
  }

  // Get a stream of incoming requests for a user.
  Stream<List<RequestModel>> getIncomingRequests(String userId) {
    return _requestsCollection
        .where('toUserId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) =>
                    RequestModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList();
        });
  }

  // Get a stream of outgoing requests for a user.
  Stream<List<RequestModel>> getOutgoingRequests(String userId) {
    return _requestsCollection
        .where('fromUserId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) =>
                    RequestModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList();
        });
  }

  // Update the status of a request.
  Future<void> updateRequestStatus(String requestId, String status) async {
    await _requestsCollection.doc(requestId).update({'status': status});
  }

  // --- Rating Methods ---

  Future<void> addRating(RatingModel rating) async {
    await _ratingsCollection.doc(rating.id).set(rating.toMap());
  }
}
