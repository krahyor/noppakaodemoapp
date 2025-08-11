// app2_shell.dart
// Shell สำหรับ Mini App 2 (โครงเหมือน App1 แต่เปลี่ยนชื่อ/ไอคอน)

import 'package:flutter/material.dart';
import 'pages/students.dart';
import 'pages/scores.dart';
import 'pages/subjects.dart';

class App2Shell extends StatefulWidget {
  const App2Shell({super.key});

  @override
  State<App2Shell> createState() => _App2ShellState();
}

class _App2ShellState extends State<App2Shell> {
  int _currentIndex = 0;
  late final List<Widget> _tabs = const [Students(), Score(), Subject()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Student',
          ),
          NavigationDestination(icon: Icon(Icons.score_sharp), label: 'Score'),
          NavigationDestination(
            icon: Icon(Icons.book_rounded),
            label: 'Subject',
          ),
        ],
      ),
    );
  }
}
