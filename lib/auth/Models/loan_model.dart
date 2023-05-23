class LoanModel {
  final dynamic id;
  final dynamic client;
  final dynamic loan_amount;
  final dynamic interest_rate;
  final dynamic loan_status;
  final dynamic bank;
  final dynamic loan_start_date;
  final dynamic loan_end_date;
  final dynamic repayment_method;
  LoanModel({
    required this.id,
    required this.client,
    required this.loan_amount,
    required this.interest_rate,
    required this.loan_status,
    required this.bank,
    required this.loan_start_date,
    required this.loan_end_date,
    required this.repayment_method,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      loan_amount: json['loan_amount'],
      interest_rate: json['interest_rate'],
      loan_start_date: json['loan_start_date'],
      loan_end_date: json['loan_end_date'],
      repayment_method: json['repayment_method'],
      loan_status: json['loan_status'],
      client: json['client'],
      bank: json['bank'],
    );
  }
}
