import 'package:c3_video_downloader/providers/connection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NewConnectionPage extends StatefulWidget {
  const NewConnectionPage({Key? key}) : super(key: key);

  @override
  State<NewConnectionPage> createState() => _NewConnectionPageState();
}

class _NewConnectionPageState extends State<NewConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _keyController = TextEditingController();
  bool _isTestingConnection = false;

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
                    maxLines: 10,
                  ),
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
        if (_isTestingConnection) {
          return;
        }
        if (_formKey.currentState?.validate() ?? false) {
          final ConnectionProvider provider =
              Provider.of(context, listen: false);
          setState(() {
            _isTestingConnection = true;
          });
          final result = await provider.testConnection(
            host: _hostController.text,
            privateKey: _keyController.text,
          );
          _showAlertDialog(result);
          setState(() {
            _isTestingConnection = false;
          });
        }
      },
      child: _isTestingConnection
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : const Text('Test'),
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
}
