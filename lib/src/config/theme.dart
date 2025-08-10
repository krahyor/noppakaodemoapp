// theme.dart
// Centralized Theme configuration (Material 3)
import 'package:flutter/material.dart';

ThemeData buildThemeData() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
  brightness: Brightness.light,
);
