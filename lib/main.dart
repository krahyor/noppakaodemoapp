// main.dart
// Entry point: ใช้ RootApp (demo sidebar + mini apps) แยกจากโครง clean architecture เดิม
// หากต้องการกลับไปใช้โครงก่อนหน้า ให้ปรับให้ runApp เป็น NoppakaoApp ตามไฟล์ app.dart เดิม
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RootApp());
}
