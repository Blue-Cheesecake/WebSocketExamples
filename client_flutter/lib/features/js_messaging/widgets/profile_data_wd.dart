import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/logic.dart';

class ProfileDataWD extends ConsumerWidget {
  const ProfileDataWD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(profileMessagingStreamProvider).when(
          data: (data) => Column(
            children: [
              Text('Fullname: ${data.fullName}'),
              Text('Age: ${data.age}'),
              Text('Counter: ${data.counter}'),
            ],
          ),
          error: (error, stackTrace) {
            return const Text('Stream Error');
          },
          loading: () => const CircularProgressIndicator(),
        );
  }
}
