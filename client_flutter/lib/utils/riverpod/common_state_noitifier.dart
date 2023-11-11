import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonStateNotifier<T> extends StateNotifier<T> {
  CommonStateNotifier(super.state);

  T? get safeState {
    if (!mounted) {
      return null;
    }
    return state;
  }

  set safeState(T? value) {
    if (!mounted || value == null) {
      log('Cannot set safeState of $T. Mounted: $mounted, Value: $value');
      return;
    }
    state = value;
  }
}
