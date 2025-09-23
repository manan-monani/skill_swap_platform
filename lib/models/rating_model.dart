// This file defines the RatingModel class, which represents a rating given by one user to another.

class RatingModel {
  // The unique identifier of the rating.
  final String id;
  // The unique identifier of the user who gave the rating.
  final String fromUserId;
  // The unique identifier of the user who received the rating.
  final String toUserId;
  // The unique identifier of the skill the rating is for.
  final String skillId;
  // The rating value (e.g., from 1 to 5).
  final double rating;
  // A comment with the rating.
  final String? comment;
  // The date and time the rating was created.
  final DateTime createdAt;

  // Constructor for the RatingModel class.
  RatingModel({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.skillId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  // Factory method to create a RatingModel instance from a map (e.g., from Firestore).
  factory RatingModel.fromMap(Map<String, dynamic> data) {
    return RatingModel(
      id: data['id'],
      fromUserId: data['fromUserId'],
      toUserId: data['toUserId'],
      skillId: data['skillId'],
      rating: data['rating'],
      comment: data['comment'],
      createdAt: data['createdAt'].toDate(),
    );
  }

  // Method to convert a RatingModel instance to a map (e.g., to save to Firestore).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'skillId': skillId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}
