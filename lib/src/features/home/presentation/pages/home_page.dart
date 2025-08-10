import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Noppakao Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Counter: $count', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              icon: const Icon(Icons.add),
              label: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
