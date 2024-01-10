import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../../application/bloc/list_item.bloc.dart';
import '../../application/ports/list_item_repository.port.dart';
import '../../application/use_cases/fetch_items.use_case.dart';
import '../repositories/list_item.repository.dart';
import '../utils/data_base.helper.dart';

final getIt = GetIt.instance;
Future<void> setUpLocator() async {
  getIt.registerSingletonAsync<Database>(() => DatabaseHelper.initializeDB());
  await getIt.isReady<Database>();
  getIt.registerSingletonWithDependencies<ListItemRepositoryPort>(
    () => SqfliteListItemRepository(getIt<Database>()),
    dependsOn: [Database],
  );
  getIt.registerLazySingleton<ListItemBloc>(() => ListItemBloc(
      fetchListItems: FetchListItems(getIt<ListItemRepositoryPort>())));
}
