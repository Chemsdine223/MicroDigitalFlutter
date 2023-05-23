import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/history_cubit.dart';
import 'package:microdigital/screens/loading.dart';

import '../app_localizations.dart';
import '../components/fields.dart';

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
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    // color: Colors.red,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.translate('Current loan'),
                        style: const TextStyle(
                          fontSize: 50,
                          fontFamily: 'QuickSand',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InfoTile(
                            fieldName: AppLocalizations.of(context)!
                                .translate('Amount'),
                            fieldContent:
                                state.loanModel.loan_amount.toString(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InfoTile(
                            fieldName: AppLocalizations.of(context)!
                                .translate('Intrest rate'),
                            fieldContent: '${state.loanModel.interest_rate}%',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InfoTile(
                            fieldName: 'Bank',
                            fieldContent: state.loanModel.bank.toString(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InfoTile(
                            fieldName: AppLocalizations.of(context)!
                                .translate('Start date'),
                            fieldContent:
                                state.loanModel.loan_start_date.toString(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InfoTile(
                            fieldName: AppLocalizations.of(context)!
                                .translate('Payment method'),
                            fieldContent:
                                state.loanModel.repayment_method.toString(),
                          ),
                          // FloatingActionButton(
                          //   onPressed: () {
                          //     LoanData().getLoanData();
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CircleAvatar(
                        radius: 100, backgroundColor: color,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'Img/money-bag.png',
                                height: 100,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate(state.loanModel.loan_status),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'QuickSand',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),

                        // radius: MediaQuery.of(context).size.width,
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.yellow,
                      //       borderRadius: BorderRadius.circular(60)),
                      //   height: 200,
                      //   width: 200,
                      // ),
                    ),
                  )
                ],
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
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     LoanData().getLoanData();
                      //   },
                      // ),
                      Image.asset(
                        'Img/time-left.png',
                        height: MediaQuery.of(context).size.height / 3.8,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('You don\'t have an active loan yet'),
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
      ),
    );
  }
}
