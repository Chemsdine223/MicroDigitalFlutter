import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SpinKitFoldingCube(
              color: Colors.teal,
            ),
          ),
        );
      },
    );
  }
}
