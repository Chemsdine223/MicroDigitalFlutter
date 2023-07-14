import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _loanAmount = 0.0;
  final double _loanAmountSlider = 0.0;
  final double _monthlyPayment = 0.0;
  final double _monthlyPaymentSlider = 0.0;
  final double _monthsToPay = 0.0;
  final double _monthsToPaySlider = 0.0;
  double loanAmount = 10000;
  double interestRate = 5.0;
  double duration = 12;
  double monthlyPayment = 0;
  int months = 0;
  bool isSelected = false;
  bool selected = false;
  int? selectedContainerIndex;

  void calculatePayment() {
    double principal = loanAmount;
    double monthlyInterestRate = interestRate / 100 / 12;
    double numberOfPayments = duration;

    double numerator =
        monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfPayments);
    double denominator = pow(1 + monthlyInterestRate, numberOfPayments) - 1;
    double monthlyPayment = principal * (numerator / denominator);

    setState(
      () {
        this.monthlyPayment = monthlyPayment;
        months = numberOfPayments.toInt();
      },
    );
  }

  double calculateMaximumPayment() {
    return loanAmount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // if (selected) {
                                selectedContainerIndex = 0;

                                // }
                                isSelected = !isSelected;
                              });
                            },
                            child: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: selectedContainerIndex == 0
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.teal,
                                        )
                                      : null,
                                  // border: const Border(),
                                  // image: DecorationImage(image: image),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.teal,
                                        blurRadius: 3,
                                        offset: Offset(2, 1)),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Img/car.png',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    Text(AppLocalizations.of(context)!
                                        .translate('Car loan')),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // if (isSelected) {
                                selectedContainerIndex = 1;
                                // }
                              });
                            },
                            child: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: selectedContainerIndex == 1
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.teal,
                                        )
                                      : null,
                                  // image: DecorationImage(image: image),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.teal,
                                        blurRadius: 3,
                                        offset: Offset(2, 1)),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Img/office-building.png',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    Text(AppLocalizations.of(context)!
                                        .translate('Real estate')),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedContainerIndex = 2;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: selectedContainerIndex == 2
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.teal,
                                        )
                                      : null,
                                  // image: DecorationImage(image: image),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.teal,
                                        blurRadius: 3,
                                        offset: Offset(2, 1)),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Img/family-trip.png',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    Text(AppLocalizations.of(context)!
                                        .translate('Personal loan')),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height / 2,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // 'Amount (in MRO)',
                                  AppLocalizations.of(context)!
                                      .translate('Amount (in MRO)'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'QuickSand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal[400],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.black45,
                                        ),
                                      ]),
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ' ${loanAmount.toStringAsFixed(0)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // first Slider
                          Slider(
                            activeColor: Colors.teal,
                            inactiveColor: Colors.tealAccent,
                            min: 1000,
                            max: 100000,
                            // divisions: 10,
                            value: loanAmount,
                            onChanged: (value) {
                              setState(() {
                                loanAmount = value;
                                calculatePayment();
                              });
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('Interest rate'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'QuickSand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal[400],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.black45,
                                        ),
                                      ]),
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ' ${interestRate.toStringAsFixed(0)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // second slider
                          Slider(
                            activeColor: Colors.teal,
                            inactiveColor: Colors.tealAccent,
                            min: 1,
                            max: 10,
                            // divisions: 9,
                            value: interestRate,
                            onChanged: (value) {
                              setState(() {
                                interestRate = value;
                                calculatePayment();
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('Duration'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'QuickSand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal[400],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.black45,
                                        ),
                                      ]),
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ' ${(monthlyPayment / 12).toStringAsFixed(0)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // third slider ------------>//
                          Slider(
                            activeColor: Colors.teal,
                            inactiveColor: Colors.tealAccent,
                            min: 1,
                            max: 60,
                            divisions: 59,
                            value: duration,
                            onChanged: (value) {
                              setState(() {
                                duration = value;
                                calculatePayment();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('Monthly Payment :'),
                                          style: TextStyle(
                                            fontFamily: 'QuickSand',
                                            fontSize: 30,
                                          ),
                                        ),
                                        Text(
                                          '${monthlyPayment.toStringAsFixed(0)} MRO',
                                          style: const TextStyle(
                                            fontFamily: 'QuickSand',
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.black38,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 14,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('Start simulation'),
                            style: const TextStyle(
                              fontFamily: 'QuickSand',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Text('HomePage'),
                  // ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
