import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/Logic/cubit/loan_cubit.dart';
import 'package:microdigital/Logic/logics.dart';
import 'package:microdigital/screens/home.dart';
import 'package:microdigital/screens/login.dart';
import 'package:microdigital/screens/sign_up.dart';
import 'package:microdigital/screens/splash.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => LoanCubit(),
              ),
            ],
            child: const Logic(),
          ),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUp(),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const HomeScreen(),
          ),
        );
      case '/splash':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No page found sorry'),
                  ),
                ));
    }
  }
}
