import 'package:flutter/services.dart';
import 'package:ssh2/ssh2.dart';

class ConnectionProvider {
  Future<String> testConnection({
    required String host,
    required String privateKey,
  }) async {
    final client = SSHClient(
      host: host,
      port: 22,
      username: 'comma',
      passwordOrKey: {'privateKey': privateKey},
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
