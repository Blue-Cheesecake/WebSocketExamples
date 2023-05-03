import 'dart:io';
import 'dart:typed_data';

Future<void> main(List<String> args) async {
  // connect to server
  final Socket socket = await Socket.connect("0.0.0.0", 3000);
  print(
      "[Client]: Connected to ${socket.remoteAddress.address}:${socket.port}");

  // listen notification from server
  socket.listen(
    (Uint8List event) {
      final String response = String.fromCharCodes(event);
      print("[Client]: Server response $response");
    },
    onError: (error) {
      print("[Client]: $error");
      socket.destroy();
    },
    onDone: () {
      print("[Client]: Server left.");
      socket.destroy();
    },
  );
}
