import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/canceled_task_screen.dart';
import 'package:task_management/ui/screens/completed_task_screen.dart';
import 'package:task_management/ui/screens/new_task_screen.dart';
import 'package:task_management/ui/screens/progress_screen.dart';

import '../widgets/tm_appbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: "New",
          ),
          NavigationDestination(
            icon: Icon(Icons.run_circle),
            label: "Progress",
          ),
          NavigationDestination(
            icon: Icon(Icons.done),
            label: "Complete",
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancel",
          ),
        ],
      ),
    );
  }
}

