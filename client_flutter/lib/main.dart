import 'package:flutter/material.dart';

import 'features/js_messaging/js_messaging.dart';

void main() {
  runApp(const MainAppWD());
}

class MainAppWD extends StatelessWidget {
  const MainAppWD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Homepage(),
        '/jsMessaging': (context) => const JSMessagingPage(),
      },
      initialRoute: "/",
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/jsMessaging');
            },
            child: const Text('JS MESSAGING')),
      ),
    );
  }
}
