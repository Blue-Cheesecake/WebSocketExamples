import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';

class CLIFStateNotifier<T> extends StateNotifier<T> {
  CLIFStateNotifier(super.state);

  static const _location = 'CLIFStateNotifier';

  T? get safeState {
    if (!mounted) {
      return null;
    }
    return state;
  }

  set safeState(T? value) {
    if (!mounted || value == null) {
      CLIFLogger.error(location: _location, message: 'Cannot set safeState of $T. Mounted: $mounted, Value: $value');
      return;
    }
    state = value;
  }
}
