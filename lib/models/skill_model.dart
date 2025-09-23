// This file defines the SkillModel class, which represents a skill in the skill_swap_platform application.

class SkillModel {
  // The unique identifier of the skill.
  final String id;
  // The name of the skill.
  final String name;
  // A description of the skill.
  final String description;
  // The unique identifier of the user who created the skill.
  final String userId;
  // The category of the skill.
  final String category;

  // Constructor for the SkillModel class.
  SkillModel({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.category,
  });

  // Factory method to create a SkillModel instance from a map (e.g., from Firestore).
  factory SkillModel.fromMap(Map<String, dynamic> data) {
    return SkillModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      userId: data['userId'],
      category: data['category'],
    );
  }

  // Method to convert a SkillModel instance to a map (e.g., to save to Firestore).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'category': category,
    };
  }
}
