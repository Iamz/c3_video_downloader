import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewConnectionPage extends StatelessWidget {
  const NewConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Connection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Save'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => context.go('/'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
