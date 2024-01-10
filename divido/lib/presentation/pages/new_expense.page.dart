import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewExpensePage extends StatelessWidget {
  final String phone;
  const NewExpensePage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Expense'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/contact-list'),
        ),
      ),
      body: Center(
        child: Text('New Expense with phone $phone'),
      ),
    );
  }
}
