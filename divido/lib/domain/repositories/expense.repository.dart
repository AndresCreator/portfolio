import '../entities/expense.entity.dart';
import '../entities/friend.entity.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> findExpensesByFriend(Friend friend);

  Future<List<Expense>> fetchExpenses();

  Future<List<Expense>> refreshExpenses();
}
