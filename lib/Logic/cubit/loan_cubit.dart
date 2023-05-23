import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:microdigital/auth/Models/loan_model.dart';
import 'package:microdigital/auth/authservices.dart';
import 'package:microdigital/loanData/loan_data_service.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial()) {
    checkLoan();
  }

  Future<void> checkLoan() async {
    emit(LoanLoading());
    await Future.delayed(const Duration(seconds: 2));
    await AuthService.loadTokens();
    final bool hasLoan = await LoanRepository().hasLoan();

    try {
      if (!hasLoan) {
        emit(LoanInitial());
      } else {
        emit(
          LoanRequested(message: 'You already have an active loan'),
        );
      }
    } catch (e) {
      // emit(LoanInitial());
    }
  }

  // Future<void> requestLoan(
  //   dynamic id,
  //   dynamic interestRate,
  //   dynamic loanAmount,
  //   dynamic bank,
  //   dynamic loanStartDate,
  //   dynamic loanEndDate,
  //   dynamic repaymentMethod,
  // ) async {
  //   // emit(LoanLoading());
  //   print(state.toString());
  //   try {
  //     final response = await LoanRepository.requestLoan(
  //       id,
  //       interestRate,
  //       loanAmount,
  //       bank,
  //       loanStartDate,
  //       loanEndDate,
  //       repaymentMethod,
  //     );
  //     final bool res = response;
  //     print(res);
  //     if (!res) {
  //       print(response);
  //       print(state.toString());
  //       emit(LoanSuccess());
  //     } else {
  //       emit(LoanError());
  //     }
  //   } catch (e) {
  //     print(state.toString());
  //     emit(LoanError());
  //   }
  // }

  // void reset() {
  //   emit(LoanSuccess());
  // }
}
