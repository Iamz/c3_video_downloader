import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
        actions: [
          IconButton(
            onPressed: () => context.go('/newConnection'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
