import 'package:flutter/material.dart';
import '../../features/brain_dump/brain_dump_sheet.dart';
import '../dashboard/widgets/pomodoro_timer.dart';
import '../dashboard/widgets/streak_widget.dart';
import '../dashboard/widgets/subject_folder.dart';

import '../../features/chat/chat_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showBrainDump(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BrainDumpSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBrainDump(context),
        label: const Text('Capture'),
        icon: const Icon(Icons.lightbulb_outline),
        backgroundColor: const Color(0xFF6A11CB),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Streak
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Questify',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  StreakWidget(),
                ],
              ),
              const SizedBox(height: 30),

              // AI Chat Widget
              const ChatWidget(),
              const SizedBox(height: 30),

              // Visual Timer
              const Center(child: PomodoroTimer()),
              const SizedBox(height: 30),

              // Subject Folders (Grid)
              const Text(
                'My Quests',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: const [
                  SubjectFolder(
                    title: 'Math',
                    color: Colors.blue,
                    icon: Icons.calculate,
                  ),
                  SubjectFolder(
                    title: 'Science',
                    color: Colors.green,
                    icon: Icons.science,
                  ),
                  SubjectFolder(
                    title: 'History',
                    color: Colors.brown,
                    icon: Icons.menu_book,
                  ),
                  SubjectFolder(
                    title: 'English',
                    color: Colors.orange,
                    icon: Icons.edit_note,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
