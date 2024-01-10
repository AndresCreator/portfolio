import 'package:complex_list/domain/entities/list_item.entity.dart';
import 'package:flutter/material.dart';

import '../../application/bloc/list_item.bloc.dart';
import '../../infrastructure/configuration/injection_container.dart';

class ListTileWidget extends StatelessWidget {
  final ListItem tile;
  final ListItemBloc _listItemBloc = getIt<ListItemBloc>();
  ListTileWidget({
    super.key,
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(tile.id.toString()),
      ),
      title: Text(tile.title),
      subtitle: Text(tile.description),
      trailing: Checkbox(
          value: tile.isDone,
          onChanged: (_) {
            _listItemBloc.add(MarkListItemAsDoneEvent(tile));
          }),
    );
  }
}
