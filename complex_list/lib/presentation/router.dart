import 'package:go_router/go_router.dart';

import 'views/done.page.dart';
import 'views/to_do.page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => TodoPage(),
    ),
    GoRoute(
      path: '/done',
      builder: (context, state) => const DonePage(),
    ),
  ],
);
