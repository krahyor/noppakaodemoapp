// page_a.dart - Tab A ของ Mini App 1
import 'package:flutter/material.dart';
import '../../../shared/widgets/placeholder_content.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderContent(appName: 'Mini App 1', pageName: 'Page A');
}
