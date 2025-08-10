// app.dart
// กำหนด MaterialApp หลัก พร้อมใช้ Material 3 และ route เริ่มต้น

import 'package:flutter/material.dart';
import 'layout/sidebar_layout.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noppakao Mini Apps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const SidebarLayout(),
    );
  }
}
