part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoading extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoaded extends HistoryState {
  final LoanModel loanModel;

  const HistoryLoaded(this.loanModel);
  @override
  List<Object?> get props => [loanModel];
}

class HistoryError extends HistoryState {
  @override
  List<Object?> get props => [];
}
