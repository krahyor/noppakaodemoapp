// app1_shell.dart
// Shell สำหรับ Mini App 1 มี BottomNavigationBar 3 tab และ state ภายในรักษาไว้

import 'package:flutter/material.dart';
import 'pages/page_a.dart';
import 'pages/page_b.dart';
import 'pages/page_c.dart';

class App1Shell extends StatefulWidget {
  const App1Shell({super.key});

  @override
  State<App1Shell> createState() => _App1ShellState();
}

class _App1ShellState extends State<App1Shell> {
  int _currentIndex = 0;
  late final List<Widget> _tabs = const [PageA(), PageB(), PageC()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini App 1')),
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.looks_one), label: 'A'),
          NavigationDestination(icon: Icon(Icons.looks_two), label: 'B'),
          NavigationDestination(icon: Icon(Icons.looks_3), label: 'C'),
        ],
      ),
    );
  }
}
