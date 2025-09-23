// This model represents a user in the skill_swap_platform application.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? bio;
  final String? profilePictureUrl;
  final List<String> skills; // List of skill IDs

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.bio,
    this.profilePictureUrl,
    this.skills = const [],
  });

  // Convert a UserModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'skills': skills,
    };
  }

  // Create a UserModel instance from a map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'],
      profilePictureUrl: map['profilePictureUrl'],
      // Ensure skills are parsed correctly as a List<String>.
      skills: List<String>.from(map['skills'] ?? []),
    );
  }
}
