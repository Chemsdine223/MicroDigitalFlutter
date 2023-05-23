import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';

import '../app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     LoanData().getLoanData();
                      //   },
                      // ),
                      Image.asset(
                        'Img/loan (1).png',
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('Request a loan from an app !'),
                        style: const TextStyle(
                          fontFamily: 'QuickSand',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              )
              // Center(
              //   child: Text('HomePage'),
              // ),
            ],
          ),
        );
      },
    );
  }
}
