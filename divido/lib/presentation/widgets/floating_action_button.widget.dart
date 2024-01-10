import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => context.go('/contact-list'),
    );
  }
}
