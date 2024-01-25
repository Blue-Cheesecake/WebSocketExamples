import 'package:client_flutter/core/clif_network/src/clif_web_socket_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';

final homepageRepositoryProvider = Provider.autoDispose<IHomepageRepository>((ref) {
  final caller = CLIFWebSocketCaller(event: 'onMessage', fromJsonT: MessageModel.fromJson);
  ref.onDispose(() {
    caller.dispose();
  });
  return HomepageRepository(dataSource: HomepageWebSocketDataSource(caller: caller));
});

final watchMessageUseCaseProvider = Provider.autoDispose<WatchMessaageUseCase>((ref) {
  final repository = ref.watch(homepageRepositoryProvider);
  return WatchMessaageUseCase(repository: repository);
});

final homepageStreamNotifier = StreamProvider.autoDispose<BaseResult<IMessageEntity>>((ref) async* {
  final watchMessaageUseCase = ref.watch(watchMessageUseCaseProvider);

  await for (final v in watchMessaageUseCase.execute(null)) {
    yield v;
  }
});
