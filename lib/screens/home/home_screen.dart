import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap_platform/models/skill_model.dart';
import 'package:skill_swap_platform/providers/skill_provider.dart';
import 'package:skill_swap_platform/screens/home/add_skill_card.dart';
import 'package:skill_swap_platform/screens/profile/profile_screen.dart';
import 'package:skill_swap_platform/screens/requests/requests_screen.dart';
import 'package:skill_swap_platform/screens/settings/settings_screen.dart';
import 'package:skill_swap_platform/widgets/common/loading_widget.dart';
import 'package:skill_swap_platform/widgets/skill_card.dart';

// The home screen of the skill_swap_platform application.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  // The list of widgets to be displayed in the body of the Scaffold.
  static final List<Widget> _widgetOptions = <Widget>[
    const _SkillList(),
    const RequestsScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Swap Platform'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Requests',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      // The floating action button now navigates to the AddSkillScreen.
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddSkillScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

// A private widget to display the list of skills from Firestore.
class _SkillList extends StatelessWidget {
  const _SkillList();

  @override
  Widget build(BuildContext context) {
    final skillProvider = Provider.of<SkillProvider>(context);

    return StreamBuilder<List<SkillModel>>(
      stream: skillProvider.skills,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No skills found. Add one!'));
        }
        final skills = snapshot.data!;
        return ListView.builder(
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return SkillCard(skill: skills[index]);
          },
        );
      },
    );
  }
}
