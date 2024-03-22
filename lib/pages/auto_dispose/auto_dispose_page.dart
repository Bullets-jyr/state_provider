import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auto_dispose_provider.dart';

class AutoDisposePage extends ConsumerWidget {
  const AutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(autoDisposeAgeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeStateProvider'),
      ),
      body: Center(
        child: Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // state를 이전 value에 기반해서 update를 해야하는 경우 (2가지 방법)
          // ref.read(autoDisposeCounterProvider.notifier).state = ref.read(autoDisposeCounterProvider.notifier).state + 10;
          ref.read(autoDisposeCounterProvider.notifier).update((state) => state + 10);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
