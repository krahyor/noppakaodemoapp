import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/app_router.dart';
import '../config/theme.dart';

class NoppakaoApp extends ConsumerWidget {
  const NoppakaoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Noppakao',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      routerConfig: router,
    );
  }
}
