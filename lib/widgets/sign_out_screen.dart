import 'package:async_notifier_example_riverpod/notifiers/auth_controller_manual.dart';
import 'package:async_notifier_example_riverpod/widgets/auth_button.dart';
import 'package:async_notifier_example_riverpod/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../notifiers/counter_manual.dart';
import '../notifiers/memory_cache.dart';

/// Simple account screen showing a logout button.
class SignOutScreen extends ConsumerWidget {
  const SignOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AuthButton(
            text: 'Sign out',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final currentCounter = ref.read(counterProvider);
              ref.read(cacheProvider).saveCacheData(currentCounter.toString());
            },
            child: Text('cachedValue: ${ref.watch(cacheProvider).cachedData}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
          ),
        ]
        ),
      ),
      floatingActionButton: const CounterWidget(),
    );
  }
}
