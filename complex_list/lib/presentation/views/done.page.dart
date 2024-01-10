import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/dymanic_list.widget.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Done'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () {
              context.go('/');
            },
          )
        ],
      ),
      body: const DynamicList(
        listType: ListType.completed,
      ),
    );
  }
}
