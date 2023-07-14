import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/history_cubit.dart';
import 'package:microdigital/screens/loading.dart';

import '../app_localizations.dart';

class LoanHistory extends StatefulWidget {
  const LoanHistory({super.key});

  @override
  State<LoanHistory> createState() => _LoanHistoryState();
}

class _LoanHistoryState extends State<LoanHistory> {
  late Color color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            print(state);
            return RefreshIndicator(
              displacement: 60,
              onRefresh: () async {
                // print(state);
                await Future.delayed(Duration(seconds: 1));
                context.read<HistoryCubit>().checkLoan();
                // print(state);
              },
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const LoadingScreen();
                  } else if (state is HistoryLoaded) {
                    switch (state.loanModel.loan_status) {
                      case 'Refused':
                        color = Colors.red;
                        break;
                      case 'Success':
                        color = Colors.green;
                        break;
                      case 'Confirmed':
                        color = Colors.teal;
                        break;
                      case 'Pending':
                        color = Colors.orange;
                        break;
                      default:
                        color = Colors.yellow;
                    }
                    return SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 12,
                            // color: Colors.red,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('Current loan'),
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'QuickSand',
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2,
                                        offset: Offset(2, 3),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: Colors.redAccent,
                              height: MediaQuery.of(context).size.height / 2.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Amount'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.loanModel.interest_rate
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Intrest rate'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${state.loanModel.loan_amount}%',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Bank'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.loanModel.bank,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Start date'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.loanModel.loan_start_date,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Payment method'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.loanModel.repayment_method,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'QuickSand',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: 40),
                          Center(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: color,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'Img/money-bag.png',
                                      height: 100,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                          state.loanModel.loan_status),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'QuickSand',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                        ],
                      ),
                    );
                  } else {
                    print(state.toString());
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'Img/time-left.png',
                              height: MediaQuery.of(context).size.height / 3.8,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate(
                                  'You don\'t have an active loan yet'),
                              style: const TextStyle(
                                fontFamily: 'QuickSand',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
