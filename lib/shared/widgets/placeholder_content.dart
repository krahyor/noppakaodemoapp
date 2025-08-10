// placeholder_content.dart
// Widget แสดง placeholder พร้อมชื่อ mini app และชื่อหน้า

import 'package:flutter/material.dart';

class PlaceholderContent extends StatelessWidget {
  final String appName;
  final String pageName;
  const PlaceholderContent({
    super.key,
    required this.appName,
    required this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.dashboard_customize, size: 72, color: scheme.primary),
          const SizedBox(height: 24),
          Text(
            appName,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(pageName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(
            'นี่คือ placeholder ของ $pageName ใน $appName',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
