part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

class AppStarted extends ExpensesEvent {}

class RefreshExpenses extends ExpensesEvent {}
