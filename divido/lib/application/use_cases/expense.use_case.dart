import '../../domain/entities/expense.entity.dart';
import '../../domain/entities/friend.entity.dart';
import '../../domain/repositories/expense.repository.dart';

class ExpenseUseCase implements ExpenseRepository {
  @override
  Future<List<Expense>> fetchExpenses() {
    // TODO: implement fetchExpenses
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> findExpensesByFriend(Friend friend) {
    // TODO: implement findExpensesByFriend
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> refreshExpenses() {
    // TODO: implement refreshExpenses
    throw UnimplementedError();
  }
}
