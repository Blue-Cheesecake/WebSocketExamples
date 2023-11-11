import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';
import '../logic.dart';

final jsMessagingRepositoryProvider = Provider.autoDispose<IJSMessagingRepository>((ref) {
  return JSMessagingRepository(dataSource: JSMessagingLocalDataSource());
});

final watchProfileUseCaseProvider = Provider.autoDispose<WatchProfileUseCase>((ref) {
  final repository = ref.watch(jsMessagingRepositoryProvider);
  return WatchProfileUseCase(repository: repository);
});

final profileMessagingStreamProvider = StreamProvider.autoDispose<IProfileEntity>((ref) {
  final watchProfileUseCase = ref.watch(watchProfileUseCaseProvider);
  final notifier = ProfileMessagingStreamNotifier(watchProfileUseCase: watchProfileUseCase);
  final stream = notifier.build();
  return stream;
});
