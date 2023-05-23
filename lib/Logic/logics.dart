import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/Logic/cubit/loan_cubit.dart';
import 'package:microdigital/screens/home.dart';
import 'package:microdigital/screens/login.dart';

import '../screens/loading.dart';
import '../screens/splash.dart';

class Logic extends StatefulWidget {
  const Logic({super.key});

  @override
  State<Logic> createState() => _LogicState();
}

class _LogicState extends State<Logic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
              ),
            );
          } else if (state is LoanSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Success")));
          } else if (state is LoanError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Success")));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingScreen();
          } else if (state is AuthSuccess) {
            return const HomeScreen();
          } else if (state is FirstTimeUser) {
            // Navigator.pushReplacementNamed(context, '/login');
            return const SplashScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
