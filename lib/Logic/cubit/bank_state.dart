part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  // @override
  // List<Object> get props => [];
}

class BankInitial extends BankState {
  @override
  List<Object?> get props => [];
}

class BankLoading extends BankState {
  @override
  List<Object?> get props => [];
}

class BankLoaded extends BankState {
  final List<Bank> banks;

  const BankLoaded(this.banks);

  @override
  List<Object?> get props => [banks];
}
