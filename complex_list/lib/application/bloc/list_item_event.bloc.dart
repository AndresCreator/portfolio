part of 'list_item.bloc.dart';

abstract class ListItemEvent {}

class FetchListItemsEvent extends ListItemEvent {
  final int startIndex;
  final int limit;

  FetchListItemsEvent({required this.startIndex, required this.limit});
}

class FetchDoneListItemsEvent extends ListItemEvent {
  final int startIndex;
  final int limit;

  FetchDoneListItemsEvent({required this.startIndex, required this.limit});
}

class AddListItemEvent extends ListItemEvent {
  final ListItem item;
  AddListItemEvent(this.item);
}

class MarkListItemAsDoneEvent extends ListItemEvent {
  final ListItem item;
  MarkListItemAsDoneEvent(this.item);
}
