import 'dart:convert';

import 'package:http/http.dart' as http;

import '../auth/Models/bank_model.dart';
import '../auth/authservices.dart';

const apiUrl = 'http://127.0.0.1:8000/';
const loanUrl = '$apiUrl/transaction/loans/';
const bankUrl = '$apiUrl/getBanks';
const loansMade = '$apiUrl/transaction/loans/';

class LoanRepository {
  List<Bank> banks = [];
  static Future<bool> requestLoan(
    dynamic id,
    dynamic loanAmount,
    dynamic interestRate,
    dynamic bank,
    dynamic loanStartDate,
    dynamic loanEndDate,
    dynamic repaymentMethod,
  ) async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }
    final url = Uri.parse(loanUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.accessToken}',
      },
      body: jsonEncode(
        {
          "client": id,
          "loan_amount": loanAmount,
          "interest_rate": interestRate,
          "bank": bank,
          "loan_start_date": loanStartDate,
          "loan_end_date": loanEndDate,
          "repayment_method": repaymentMethod
        },
      ),
    );
    // final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('hello');
      // final loan = LoanModel.fromJson(data);
      return true;
    } else {
      print('What the hell is this ?');
      return false;
    }
  }

  Future<List<Bank>> fetchBankList() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/transaction/getbanks/'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Bank> bankList = jsonList.map((e) => Bank.fromJson(e)).toList();
      for (var i = 0; i < bankList.length; i++) {
        bankList[i];
      }
      print(bankList);
      return bankList;
    } else {
      throw Exception('Failed to load bank list');
    }
  }

  Future<bool> hasLoan() async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }
    final response = await http.get(
        Uri.parse(
          'http://127.0.0.1:8000/transaction/loans/${AuthService.id}',
        ),
        headers: {'Authorization': 'Bearer ${AuthService.accessToken}'});
    await AuthService.loadTokens();
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      print('${response.statusCode} 111-------------');
      return false;
    }
  }
}
