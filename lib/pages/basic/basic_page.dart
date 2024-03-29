import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'basic_provider.dart';

class BasicPage extends ConsumerWidget {
  const BasicPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<state의 타입>
    // ref.listen<int>(
    //   listen할 Provider
    //   counterProvider,
    //   (previous, next) {
    //     if (next == 3) {
    //       showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             content: Text('counter: $next'),
    //           );
    //         },
    //       );
    //     }
    //   },
    // );

    final value = ref.watch(ageProvider);

    // final value = ref.watch(counterProvider);

    // if (value == 3) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Text('counter: $value'),
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: Center(
        child: Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final val = ref.read(counterProvider.notifier).state++;
          // ref.read(counterProvider.notifier).state = ref.read(counterProvider.notifier).state + 0;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
