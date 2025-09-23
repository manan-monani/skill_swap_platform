import 'package:flutter/material.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/screens/home/skill_details_screen.dart';

// A widget that displays a skill in a card format.
class SkillCard extends StatelessWidget {
  final SkillModel skill;

  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(skill.name),
        subtitle: Text(skill.category),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to the skill details screen when the card is tapped.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SkillDetailsScreen(skill: skill),
            ),
          );
        },
      ),
    );
  }
}
