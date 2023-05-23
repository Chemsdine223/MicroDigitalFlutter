part of 'loan_cubit.dart';

abstract class LoanState extends Equatable {}

class LoanInitial extends LoanState {
  @override
  List<Object?> get props => [];
}

class LoanLoading extends LoanState {
  @override
  List<Object?> get props => [];
}

class BankError extends LoanState {
  @override
  List<Object?> get props => [];
}

class LoanLoaded extends LoanState {
  final LoanModel loanModel;
  // final List<Bank> bank;

  LoanLoaded(
    this.loanModel,
    // this.bank,
  );

  @override
  List<Object?> get props => [loanModel];
}

class LoanError extends LoanState {
  @override
  List<Object?> get props => [];
}

class LoanSuccess extends LoanState {
  @override
  List<Object?> get props => [];
}

class LoanRequested extends LoanState {
  final String message;
  LoanRequested({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
