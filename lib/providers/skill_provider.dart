import 'package:flutter/material.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';

// This provider manages the skills in the application.
class SkillProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  // A stream of skills from Firestore.
  Stream<List<SkillModel>> get skills => _firestoreService.getSkills();

  // Add a new skill.
  Future<void> addSkill(SkillModel skill) async {
    await _firestoreService.addSkill(skill);
    notifyListeners();
  }
}
