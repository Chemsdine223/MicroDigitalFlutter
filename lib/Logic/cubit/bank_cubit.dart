import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../auth/Models/bank_model.dart';
import '../../loanData/loan_data_service.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit() : super(BankInitial()) {
    getBankList();
  }

  Future<void> getBankList() async {
    // emit(LoanLoading() as BankState);
    emit(BankLoading());
    try {
      final banks = await LoanRepository().fetchBankList();
      emit(BankLoaded(banks));
    } catch (e) {
      emit(BankInitial());
    }
  }
}
