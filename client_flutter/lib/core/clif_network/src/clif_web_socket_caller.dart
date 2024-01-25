import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as si;

import 'package:client_flutter/utils/utils.dart';
import 'package:client_flutter/core/core.dart';

final class CLIFWebSocketCaller<T> implements IDisposable {
  CLIFWebSocketCaller({
    required String event,
    required this.fromJsonT,
  }) : _event = event {
    _listenOnEvent();
  }

  final String _event;
  late final si.Socket _socket;
  final StreamController<T> _streamController = StreamController.broadcast();
  final T Function(Map<String, dynamic>) fromJsonT;

  Stream<T> get eventStream => _streamController.stream;

  void _listenOnEvent() async {
    // final token = await CLIFUser.instance.token;
    final url = AppConfig.instance.apiURL;

    _socket = si.io(
      url,
      si.OptionBuilder().setTransports(['websocket']).enableAutoConnect().build(),
    );

    _socket.on(_event, (data) {
      final T model = fromJsonT(data as Map<String, dynamic>);
      _streamController.add(model);
    });
  }

  @override
  void dispose() {
    _socket.close();
    _streamController.close();
  }
}
