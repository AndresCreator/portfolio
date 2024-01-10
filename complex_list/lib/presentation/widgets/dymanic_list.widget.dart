import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc/list_item.bloc.dart';
import '../../domain/entities/list_item.entity.dart';
import '../../infrastructure/configuration/injection_container.dart';
import 'list_tile.widget.dart';

enum ListType {
  all,
  completed,
}

class DynamicList extends StatefulWidget {
  final ListType listType;
  const DynamicList({super.key, this.listType = ListType.all});

  @override
  State<DynamicList> createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  final _scrollController = ScrollController();
  late final ListItemBloc _listItemBloc;
  List<ListItem> _items = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _listItemBloc = getIt<ListItemBloc>();
    _fetchItems();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchItems();
    }
  }

  void _fetchItems() {
    if (widget.listType == ListType.all) {
      _listItemBloc
          .add(FetchListItemsEvent(startIndex: _items.length, limit: 20));
    } else if (widget.listType == ListType.completed) {
      _listItemBloc
          .add(FetchDoneListItemsEvent(startIndex: _items.length, limit: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemBloc, ListItemState>(
      bloc: _listItemBloc,
      builder: (context, state) {
        if (state is ListItemInitial) {
          _fetchItems();
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListItemLoaded || state is ListItemLoading) {
          _items = state.items; // Update _items with the loaded data
          log(_items.length.toString());
          return ListView.builder(
              controller: _scrollController,
              itemCount: _items.length + (state is ListItemLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _items.length) {
                  return ListTileWidget(
                    tile: _items[index],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        } else if (state is ListItemError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    // _listItemBloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}
