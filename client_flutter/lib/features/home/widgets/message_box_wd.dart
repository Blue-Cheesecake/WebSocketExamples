import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../domain/domain.dart';

class MessageBoxWD extends StatelessWidget {
  const MessageBoxWD({super.key, required this.message});

  final IMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: DesignSystem.g1,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: DesignSystem.g0.withOpacity(0.1),
          )
        ],
      ),
      child: Text('Counter: ${message.counter}'),
    );
  }
}
