import 'package:c3_video_downloader/pages/connections.dart';
import 'package:c3_video_downloader/pages/new_connection.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ConnectionsPage(),
    ),
    GoRoute(
      path: '/newConnection',
      builder: (context, state) => const NewConnectionPage(),
    ),
  ],
);
