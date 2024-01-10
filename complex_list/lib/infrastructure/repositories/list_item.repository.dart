import 'dart:developer';

import 'package:complex_list/application/ports/list_item_repository.port.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/list_item.entity.dart';

class SqfliteListItemRepository implements ListItemRepositoryPort {
  final Database database;

  SqfliteListItemRepository(this.database);

  @override
  Future<List<ListItem>> fetchItems(
    int startIndex,
    int limit,
    int value,
  ) async {
    log("fetchItems $value");
    await Future.delayed(const Duration(seconds: 2));
    final List<Map<String, dynamic>> maps = await database.query(
      'items',
      where: 'isDone = ?',
      whereArgs: [value],
      offset: startIndex,
      limit: limit,
    );

    return List.generate(maps.length, (i) {
      return ListItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isDone: maps[i]['isDone'] == 1 ? true : false,
      );
    });
  }

  @override
  Future<ListItem> addItem(ListItem item) async {
    final Map<String, dynamic> itemMap = item.toMap();

    int id = await database.insert(
      'items',
      itemMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return item.copyWith(id: id);
  }

  @override
  Future<ListItem> markItemAsDone(ListItem item) async {
    final ListItem itemDone = item.copyWith(isDone: true);
    final Map<String, dynamic> itemMap = itemDone.toMap();
    log(itemMap.toString());
    await database.update(
      'items',
      itemMap,
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return itemDone;
  }
}
