import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/expense.entity.dart';
import '../../domain/repositories/expense.repository.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpenseRepository expenseRepository;

  ExpensesBloc({required this.expenseRepository}) : super(ExpensesInitial()) {
    on<AppStarted>(_onAppStarted);
    on<RefreshExpenses>(_onRefreshExpenses);
  }

  void _onAppStarted(AppStarted event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      final expenses = await expenseRepository.fetchExpenses();
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }

  void _onRefreshExpenses(
      RefreshExpenses event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      final expenses = await expenseRepository.refreshExpenses();
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }
}
