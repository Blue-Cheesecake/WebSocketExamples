# WebSocket Examples

This repository showcases how to create a robust connection using the WebSocket protocol. Developed with Spring Boot for server-side functionality and Dart & Flutter for client-side applications, it provides a comprehensive understanding of end-to-end communication systems.

## Prerequisites

- [Java Development Kit (JDK)](https://adoptopenjdk.net/)
- [Spring Boot](https://spring.io/projects/spring-boot)
- [Dart SDK](https://dart.dev/get-dart)
- [Flutter SDK](https://docs.flutter.dev/get-started/install)

## Codes

### WebSocket Configuration
```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketMessageConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // registry.addEndpoint("/chat-example").withSockJS();
        registry.addEndpoint("/chat-example").setAllowedOrigins("*");
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.setApplicationDestinationPrefixes("/app");
        registry.enableSimpleBroker("/topic");
    }
}
```

### Controller

```java
@Controller
public class MessageController {

    @MessageMapping("/chat.send")
    @SendTo("/topic/public")
    public Message sendMessage(final Message message) {
        return message;
    }

    @MessageMapping("/chat.newUser")
    @SendTo("/topic/public")
    public Message newUser(final Message message, SimpMessageHeaderAccessor headerAccessor) {
        // someone joined!!
        Objects.requireNonNull(headerAccessor.getSessionAttributes()).put("username", message.getSender());
        return message;
    }
}
```

### Connect to Server

```dart
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
```

### Listen and Send Requests

```dart
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
```

## Acknowledgements

This project would not have been possible without the wealth of resources and guidance available online, and there are a few key sources I'd like to express my gratitude towards:

1. The [YouTube tutorial](https://www.youtube.com/watch?v=U4lqTmFmbAM) was instrumental in guiding me through the creation of a WebSocket connection with a Spring Boot server. It provided clear, step-by-step instructions that greatly assisted in understanding the process.

2. Additionally, the [stomp_dart_client library](https://pub.dev/packages/stomp_dart_client/example) was a valuable tool in the development of the client-side connection to the server. It provided both a robust set of features that streamlined the development process.

I extend my heartfelt thanks to the creators of these resources. Your work has not only facilitated the development of this project but has also furthered my knowledge and understanding of WebSocket communication.
