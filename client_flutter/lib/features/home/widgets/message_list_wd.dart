import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/logic.dart';
import 'widgets.dart';

class MessageListWD extends ConsumerWidget {
  const MessageListWD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(homepageStreamNotifier);

    return switch (live) {
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncData(:final value) => value.when(
          success: (data) => MessageBoxWD(message: data),
          failure: (e) => const Text('Failure'),
        ),
      AsyncError(:final error) => Text(error.toString()),
      _ => const CircularProgressIndicator(),
    };
  }
}
