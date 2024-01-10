import '../../domain/entities/list_item.entity.dart';

abstract class ListItemRepositoryPort {
  Future<List<ListItem>> fetchItems(int startIndex, int limit, int done);

  Future<ListItem> addItem(ListItem item);

  Future<ListItem> markItemAsDone(ListItem item);
}
