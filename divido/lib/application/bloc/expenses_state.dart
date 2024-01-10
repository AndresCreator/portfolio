part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  ExpensesLoaded(this.expenses);
}

class ExpensesError extends ExpensesState {
  final String message;

  ExpensesError(this.message);
}
