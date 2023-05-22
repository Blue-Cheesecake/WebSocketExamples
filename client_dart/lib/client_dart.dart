import 'dart:convert';
import 'dart:io';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

StompClient client = StompClient(
  config: StompConfig(
    url: "ws://localhost:8090/chat-example",
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onConnect: onConnected,
    onStompError: onError,
    onWebSocketError: (p0) => print(p0.toString()),
  ),
);

void onConnected(StompFrame connectFrame) {
  print("Connected! ${connectFrame.headers}");
  String? username = stdin.readLineSync();
  client.subscribe(
    destination: "/topic/public",
    callback: (p0) {
      print("Got this message: ${p0.body}");
    },
  );
  client.send(
    destination: "/app/chat.newUser",
    body: jsonEncode({
      'sender': username,
      'type': 'CONNECT',
    }),
  );
}

void onError(StompFrame frame) {
  print("Error");
}

Future<void> main(List<String> args) async {
  client.activate();
}
