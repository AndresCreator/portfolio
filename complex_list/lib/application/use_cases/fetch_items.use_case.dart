import 'package:complex_list/application/ports/list_item_repository.port.dart';

import '../../domain/entities/list_item.entity.dart';

class FetchListItems {
  final ListItemRepositoryPort repository;

  FetchListItems(this.repository);

  Future<List<ListItem>> execute(int startIndex, int limit, [int done = 0]) {
    return repository.fetchItems(startIndex, limit, done);
  }

  Future<ListItem> addItem(ListItem item) {
    return repository.addItem(item);
  }

  Future<ListItem> markItemAsDone(ListItem item) {
    return repository.markItemAsDone(item);
  }
}
