import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class JSMessagingPage extends StatelessWidget {
  const JSMessagingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Websocket Example'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: ProfileDataWD(),
        ),
      ),
    );
  }
}
