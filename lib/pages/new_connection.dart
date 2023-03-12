import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ssh2/ssh2.dart';

class NewConnectionPage extends StatefulWidget {
  const NewConnectionPage({Key? key}) : super(key: key);

  @override
  State<NewConnectionPage> createState() => _NewConnectionPageState();
}

class _NewConnectionPageState extends State<NewConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _keyController = TextEditingController();

  @override
  void dispose() {
    _hostController.dispose();
    _keyController.dispose();
    super.dispose();
  }

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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _hostController,
                    decoration: const InputDecoration(hintText: 'Host'),
                    validator: (value) =>
                        value?.isNotEmpty != true ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _keyController,
                    decoration: const InputDecoration(hintText: 'Private Key'),
                    validator: (value) =>
                        value?.isNotEmpty != true ? 'Required' : null,
                    maxLines: 5,
                  )
                ],
              ),
            ),
            _buildTestButton(),
            _buildSaveButton(),
            _buildCancelButton(),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildTestButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          final result = await _testConnection();
          _showAlertDialog(result);
        }
      },
      child: const Text('Test'),
    );
  }

  void _showAlertDialog(String result) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
    }
  }

  ElevatedButton _buildCancelButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () => context.go('/'),
      child: const Text('Cancel'),
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: () => context.go('/'),
      child: const Text('Save'),
    );
  }

  Future<String> _testConnection() async {
    final client = SSHClient(
      host: _hostController.text,
      port: 22,
      username: 'comma',
      passwordOrKey: {'privateKey': _keyController.text},
    );
    try {
      await client.connect();
      final isConnected = await client.isConnected();
      return isConnected ? 'success' : 'fail';
    } catch (e) {
      if (e is PlatformException) {
        return e.message ?? 'unknown';
      } else {
        rethrow;
      }
    } finally {
      if (await client.isConnected()) {
        await client.disconnect();
      }
    }
  }
}
