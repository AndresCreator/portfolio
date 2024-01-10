import 'package:divido/presentation/widgets/default_scaffold.widget.dart';
import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      body: Center(
        child: Text('Friend List'),
      ),
    );
  }
}
