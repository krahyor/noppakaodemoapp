// sidebar_layout.dart
// Layout หลักที่มี Sidebar (NavigationRail) สำหรับเลือก mini app แต่ละอัน
// แต่ละ mini app มี state แยก (เก็บด้วย IndexedStack + ตัวควบคุมภายใน)

import 'package:flutter/material.dart';
import '../mini_apps/app1/app1_shell.dart';
import '../mini_apps/app2/app2_shell.dart';

class SidebarLayout extends StatefulWidget {
  const SidebarLayout({super.key});

  @override
  State<SidebarLayout> createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  int _selectedMiniApp = 0;

  // แต่ละ mini app จะถูกสร้างครั้งเดียวแล้วค้างไว้ เพื่อคง state ภายใน
  late final List<Widget> _miniAppShells = const [App1Shell(), App2Shell()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedMiniApp,
            onDestinationSelected: (i) => setState(() => _selectedMiniApp = i),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 40),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.apps),
                label: Text('App 1'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.auto_awesome),
                label: Text('App 2'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          // รักษา state ของแต่ละ mini app ด้วย IndexedStack
          Expanded(
            child: IndexedStack(
              index: _selectedMiniApp,
              children: _miniAppShells,
            ),
          ),
        ],
      ),
    );
  }
}
