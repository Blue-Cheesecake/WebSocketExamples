import 'package:client_flutter/core/core.dart';

import '../../domain/domain.dart';
import 'datasources.dart';

class HomepageWebSocketDataSource implements IHomepageDataSource {
  HomepageWebSocketDataSource({required this.caller});

  final CLIFWebSocketCaller<IMessageEntity> caller;

  @override
  Stream<IMessageEntity> watchMessage() {
    final response = caller.eventStream;
    return response;
  }
}
