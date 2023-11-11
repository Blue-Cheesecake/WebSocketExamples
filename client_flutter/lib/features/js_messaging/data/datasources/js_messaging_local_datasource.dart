import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/domain.dart';
import '../data.dart';

class JSMessagingLocalDataSource implements IJSMessagingDataSource {
  @override
  Stream<IProfileEntity> watchProfile() {
    // NOTE: this url should get from environment
    final wsUrl = Uri.parse('ws://localhost:8081');
    final channel = WebSocketChannel.connect(wsUrl);

    return channel.stream.map<IProfileEntity>((data) {
      final json = jsonDecode(data);
      return ProfileModel.fromJson(json);
    });
  }
}
