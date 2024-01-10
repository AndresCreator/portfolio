import 'package:divido/presentation/pages/contact_list.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'pages/friend_list.page.dart';
import 'pages/login.page.dart';
import 'pages/new_expense.page.dart';
import 'pages/otp.page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'otp',
          builder: (context, state) => OtpInputPage(
            verificationId: state.uri.queryParameters['verificationId']!,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        GoRoute(
          path: 'friend-list',
          builder: (context, state) => const FriendList(),
        ),
        GoRoute(
          path: 'new-expense',
          builder: (context, state) => NewExpensePage(
            phone: state.uri.queryParameters['phone']!,
          ),
        ),
        GoRoute(
          path: 'contact-list',
          builder: (context, state) => const ContactListPage(),
        ),
      ],
    ),
  ],
);
