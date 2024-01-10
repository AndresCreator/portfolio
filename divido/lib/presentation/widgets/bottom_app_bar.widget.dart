import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => context.go('/friend-list'),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }
}
