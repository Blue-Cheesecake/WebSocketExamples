import 'dart:io';
import 'dart:typed_data';

Future<void> main(List<String> args) async {
  // get a free IP address
  final InternetAddress ip = InternetAddress.anyIPv4;

  // Initialize the server socket
  final ServerSocket server = await ServerSocket.bind(ip, 3000);
  print("Running server on: ${ip.address}:3000");

  // Listen incoming connection and handle them
  server.listen((Socket event) {
    handleConnection(event);
  });
}

// List of all subscribers listening to this server
final List<Socket> clients = [];

void handleConnection(Socket client) {
  print(
    "[Server]: Someone is connected from ${client.remoteAddress.address}:${client.port}",
  );
  client.listen(
    // Listen for "write" information from the client
    (Uint8List data) {
      final String message = String.fromCharCodes(data);

      for (Socket subscriber in clients) {
        subscriber.write("[Server]: $message is logged in");
      }

      // Add a client to clients list
      clients.add(client);
      client.write("[Server]: You logged in as $message");
    },
    // Handle Error case.
    onError: (error) {
      print(error);
      client.close();
    },
    // Handle the client closing connection
    onDone: () {
      print("[Server]: Client is left");
      client.close();
    },
  );
}
