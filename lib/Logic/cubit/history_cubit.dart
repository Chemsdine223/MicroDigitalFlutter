import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../auth/Models/loan_model.dart';
import '../../auth/authservices.dart';
import '../../loanData/loan_data_service.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial()) {
    checkLoan();
  }

  Future<void> checkLoan() async {
    emit(HistoryLoading());
    // await Future.delayed(const Duration(seconds: 1));
    await AuthService.loadTokens();
    final bool hasLoan = await LoanRepository().hasLoan();

    try {
      emit(HistoryLoading());
      if (hasLoan) {
        final response = await LoanData().getLoanData();
        emit(HistoryLoaded(response));
      } else {
        emit(HistoryInitial());
        // emit(HistoryLoading());
      }
    } catch (e) {
      print('This is an error ---------');
      // emit(HistoryInitial());
    }
  }
}
