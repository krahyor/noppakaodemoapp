// app2_shell.dart
// Shell สำหรับ Mini App 2 (โครงเหมือน App1 แต่เปลี่ยนชื่อ/ไอคอน)

import 'package:flutter/material.dart';
import 'pages/page_x.dart';
import 'pages/page_y.dart';
import 'pages/page_z.dart';

class App2Shell extends StatefulWidget {
  const App2Shell({super.key});

  @override
  State<App2Shell> createState() => _App2ShellState();
}

class _App2ShellState extends State<App2Shell> {
  int _currentIndex = 0;
  late final List<Widget> _tabs = const [PageX(), PageY(), PageZ()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini App 2')),
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.filter_1), label: 'X'),
          NavigationDestination(icon: Icon(Icons.filter_2), label: 'Y'),
          NavigationDestination(icon: Icon(Icons.filter_3), label: 'Z'),
        ],
      ),
    );
  }
}
