import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:productivo/views/pages/initial.dart';
import 'package:productivo/views/pages/login_page.dart';
import 'package:productivo/views/pages/signup_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <GoRoute>[
        GoRoute(
          path: "signup",
          builder: (BuildContext context, GoRouterState state) {
            return const SignupPage();
          },
        ),
        GoRoute(
          path: 'initial',
          builder: (BuildContext context, GoRouterState state) {
            return const InitialPage();
          },
        ),
      ],
    ),
  ],
);
