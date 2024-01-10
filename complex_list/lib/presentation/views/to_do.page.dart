import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../application/bloc/list_item.bloc.dart';
import '../../domain/entities/list_item.entity.dart';
import '../../infrastructure/configuration/injection_container.dart';
import '../widgets/dymanic_list.widget.dart';

class TodoPage extends StatelessWidget {
  final ListItemBloc _listItemBloc = getIt<ListItemBloc>();
  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              context.go('/done');
            },
          )
        ],
      ),
      body: const DynamicList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a dialog or navigate to a new screen to get user input
          // For simplicity, let's assume we have a newItem of type ListItem
          ListItem newItem = ListItem(
            title: 'New Item',
            description: 'New Item Description',
          );
          _listItemBloc.add(AddListItemEvent(newItem));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
