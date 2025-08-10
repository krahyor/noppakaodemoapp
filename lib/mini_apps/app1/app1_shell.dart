// app1_shell.dart
// Shell สำหรับ Mini App 1 มี BottomNavigationBar 3 tab และ state ภายในรักษาไว้

import 'package:flutter/material.dart';
import 'pages/accounts.dart';
import 'pages/settings.dart';
import 'package:noppakao/services/notification_service.dart';

class App1Shell extends StatefulWidget {
  const App1Shell({super.key});

  @override
  State<App1Shell> createState() => _App1ShellState();
}

class _App1ShellState extends State<App1Shell> {
  int _currentIndex = 0;
  late final List<Widget> _tabs = const [Account(), Setting()];

  @override
  void initState() {
    super.initState();
    // Lazy init notifications only for app1
    NotificationService().ensureInitialized();
  }

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
            label: 'Account',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
