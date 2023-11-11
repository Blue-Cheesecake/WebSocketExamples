import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/iprofile_entity.dart';
import '../../domain/usecases/usecases.dart';

class ProfileMessagingStreamNotifier extends StreamNotifier<IProfileEntity> {
  ProfileMessagingStreamNotifier({required WatchProfileUseCase watchProfileUseCase})
      : _watchProfileUseCase = watchProfileUseCase;

  final WatchProfileUseCase _watchProfileUseCase;

  @override
  Stream<IProfileEntity> build() {
    final response = _watchProfileUseCase.call(null);
    return response;
  }
}
