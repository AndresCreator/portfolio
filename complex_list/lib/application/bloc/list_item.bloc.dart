import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/list_item.entity.dart';
import '../use_cases/fetch_items.use_case.dart';

part './list_item_event.bloc.dart';

part './list_item_state.bloc.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  final FetchListItems fetchListItems;
  final List<ListItem> _accumulatedItems = [];

  ListItemBloc({required this.fetchListItems}) : super(ListItemInitial()) {
    on<AddListItemEvent>(_onAddListItem);
    on<MarkListItemAsDoneEvent>(_markEventAsDone);
    on<FetchListItemsEvent>(_fetchItems);
    on<FetchDoneListItemsEvent>(_fetchDoneItems);
  }

  void _fetchItems(
      FetchListItemsEvent event, Emitter<ListItemState> emit) async {
    await _fetchAndEmitItems(event.startIndex, event.limit, 0, emit);
  }

  void _fetchDoneItems(
      FetchDoneListItemsEvent event, Emitter<ListItemState> emit) async {
    log("FetchDoneListItemsEvent");
    await _fetchAndEmitItems(event.startIndex, event.limit, 1, emit);
  }

  Future<void> _fetchAndEmitItems(int startIndex, int limit, int isDone,
      Emitter<ListItemState> emit) async {
    emit(ListItemLoading(_accumulatedItems
        .where((element) => (element.isDone ? 1 : 0) == isDone)
        .toList()));
    try {
      final newItems = await fetchListItems.execute(startIndex, limit, isDone);
      List<ListItem> filteredNewItems = newItems
          .where((newItem) => !_accumulatedItems
              .any((existingItem) => existingItem.id == newItem.id))
          .toList();

      _accumulatedItems.addAll(filteredNewItems);
      emit(ListItemLoaded(_accumulatedItems
          .where((element) => (element.isDone ? 1 : 0) == isDone)
          .toList()));
    } catch (e) {
      _handleError(e, emit);
    }
  }

  void _handleError(Object error, Emitter<ListItemState> emit) {
    emit(ListItemError("Failed to process request: ${error.toString()}"));
  }

  void _onAddListItem(
      AddListItemEvent event, Emitter<ListItemState> emit) async {
    try {
      final addedItem = await fetchListItems.addItem(event.item);
      _accumulatedItems.add(addedItem);
      emit(ListItemLoaded(
          _accumulatedItems.where((element) => !element.isDone).toList()));
    } catch (e) {
      _handleError(e, emit);
    }
  }

  void _markEventAsDone(
      MarkListItemAsDoneEvent event, Emitter<ListItemState> emit) async {
    try {
      ListItem doneItem = await fetchListItems.markItemAsDone(event.item);
      _accumulatedItems.remove(event.item);
      _accumulatedItems.add(doneItem);
      emit(ListItemLoaded(
          _accumulatedItems.where((element) => !element.isDone).toList()));
    } catch (e) {
      _handleError(e, emit);
    }
  }
}
