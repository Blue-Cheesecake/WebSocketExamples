import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as si;

import 'package:client_flutter/utils/utils.dart';
import 'package:client_flutter/core/core.dart';

final class CLIFWebSocketCaller implements IDisposable {
  CLIFWebSocketCaller({required String event}) : _event = event;

  final String _event;
  late final si.Socket _socket;
  final StreamController _streamController = StreamController.broadcast();

  Stream get eventStream => _streamController.stream;

  void listenOnEvent() async {
    final token = await CLIFUser.instance.token;
    final url = "${AppConfig.instance.apiURL}?token=$token";
    _socket = si.io(url);
    _socket.on(_event, (data) {
      _streamController.add(data);
    });
  }

  @override
  void dispose() {
    _socket.close();
    _streamController.close();
  }
}
