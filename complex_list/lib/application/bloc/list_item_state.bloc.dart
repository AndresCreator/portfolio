part of 'list_item.bloc.dart';

abstract class ListItemState {
  final List<ListItem> items;
  ListItemState({this.items = const []});
}

class ListItemInitial extends ListItemState {
  ListItemInitial() : super(items: []);
}

class ListItemLoading extends ListItemState {
  ListItemLoading(List<ListItem> items) : super(items: items);
}

class ListItemLoaded extends ListItemState {
  ListItemLoaded(List<ListItem> items) : super(items: items);
}

class ListItemError extends ListItemState {
  final String message;

  ListItemError(this.message);
}
