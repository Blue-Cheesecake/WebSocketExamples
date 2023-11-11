# WebSocket Examples

This repository demonstrates the implementation of a robust WebSocket connection. It integrates a Javascript for Server with a Flutter for Frontend to establish a full-duplex communication channel. This example serves as a practical guide to building and understanding real-time, bidirectional communication between web servers and clients.

## Table of Contents
  
  
- [WebSocket Examples](#websocket-examples)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Repository Structure](#repository-structure)
    - [Backend Part](#backend-part)
    - [Frontend Part](#frontend-part)
  - [Contributions](#contributions)
    - [What We're Looking For](#what-were-looking-for)
  - [How to Contribute](#how-to-contribute)


## Overview
WebSocket is a computer communications protocol, providing full-duplex communication channels over a single TCP connection. The repository outlines how to set up a WebSocket server and connect to it using a client application developed with Flutter. The end-to-end system facilitates the streaming of JSON-encoded data, simulating a real-time data feed.

## Prerequisites
Before running the examples, ensure you have the following prerequisites installed:

- Node.js (for the JavaScript WebSocket server)
- Flutter SDK (for the Dart & Flutter client application)

## Repository Structure
The repository is divided into two main sections: the backend (`js-massaging`) and the frontend `client_flutter`.

### Backend Part

**WebSocket Server**

The server is built using Node.js and the `ws` library, creating a WebSocket server that periodically broadcasts a JSON object to all connected clients.

```js
const websocket = require("ws");

// Create WebSocket Server
const port = 8081;
const wss = new websocket.Server({
  port: port,
});

console.log("Running WebSocket Server on Port:", port);
wss.on("connection", (ws) => {
  console.log("New client connected!");

  ws.on("message", (data) => {
    console.log("Got data from client", data);
  });

  ws.on("close", () => {
    console.log("Client has disconnected");
  });

  ws.on("error", () => {
    console.log("Something went wrong!");
  });

  // Periodically sends data
  let count = 1;
  setInterval(() => {
    ws.send(
      JSON.stringify({
        fullName: "Sinut Wattanarporn",
        age: 22,
        counter: count,
      })
    );

    count++;
  }, 1500);
});

```

The server runs on port `8081` and sends a JSON object containing user profile information at a set interval.

### Frontend Part

Client Connection
The client application, developed in Dart and Flutter, establishes a connection to the WebSocket server using the `WebSocketChannel` class. It listens for incoming JSON-encoded data, decodes it, and maps it to the `ProfileModel` class.

```dart
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
```

**State Management**

Using `riverpod`, the client application manages the state of the WebSocket stream. It leverages `StreamNotifier` and `StreamProvider` to feed the incoming data into the presentation layer, allowing for reactive UI updates.


```dart
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

```

**UI Rendering**

The `ProfileDataWD` widget listens to the `profileMessagingStreamProvider` and renders UI components according to the current state of the stream—showing data when available, displaying an error message on fault, or indicating loading progress.


```dart
import '../logic/logic.dart';

class ProfileDataWD extends ConsumerWidget {
  const ProfileDataWD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(profileMessagingStreamProvider).when(
          data: (data) => Column(
            children: [
              Text('Fullname: ${data.fullName}'),
              Text('Age: ${data.age}'),
              Text('Counter: ${data.counter}'),
            ],
          ),
          error: (error, stackTrace) {
            return const Text('Stream Error');
          },
          loading: () => const CircularProgressIndicator(),
        );
  }
}
```

## Contributions

We are actively seeking contributions to expand the versatility of our WebSocket examples. If you're proficient in languages other than JavaScript for backend development or have experience with frontend frameworks other than Flutter, your expertise could greatly benefit the diversity and comprehensiveness of this repository.

### What We're Looking For
- **Backend Implementations**: More examples of WebSocket servers in languages like Python (with frameworks like FastAPI or Django), Go, Rust, Java (with Spring or other frameworks), or any other language you're passionate about.

- **Frontend Implementations**: More examples of Client-side implementations using different technologies like Swift for iOS, Kotlin for Android, or reactive web frameworks like React, Vue.js, or Angular.

- **Additional Features**: Enhancements to the current example, including but not limited to security features like WebSocket authentication, connection resilience with reconnection strategies, or UI improvements.

- **Documentation and Tutorials**: Detailed explanations, walkthroughs, or blog posts on how the WebSocket communication is set up and executed within different frameworks and languages.

## How to Contribute

If you would like to contribute, please follow these steps:

1. Fork the Repository: Make a copy of this project on your own GitHub account.
2. Clone Your Fork: Work on your local machine and implement your features or improvements.
3. Test Thoroughly: Verify that your code works as expected and does not break existing functionality.
4. Submit a Pull Request: Open a PR against the original repository with a clear description of your changes.
  
We welcome all contributions, big or small, and are excited to see the creative ways you enhance this WebSocket example project!