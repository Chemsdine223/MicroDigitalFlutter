import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:microdigital/Logic/cubit/loan_cubit.dart';
import 'package:microdigital/app_localizations.dart';
import 'package:microdigital/auth/authservices.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:microdigital/router/router.dart';

// DDHR8JF47R4
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().initializeOneSignal();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanCubit(),
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        // localeResolutionCallback: (locale, supportedLocales) {
        //   for (var supportedLocale in supportedLocales) {
        //     if (supportedLocale.languageCode == locale!.languageCode &&
        //         supportedLocale.countryCode == locale.countryCode) {
        //       return supportedLocale;
        //     }
        //   }
        //   return supportedLocales.first;
        // },

        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            print(locale!.languageCode);
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
            print('$supportedLocale ===========');
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoutes,
      ),
    );
  }
}
