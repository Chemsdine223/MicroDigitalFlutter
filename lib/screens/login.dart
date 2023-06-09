import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Logic/cubit/auth_cubit.dart';
import '../app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Login',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 30,
              color: Colors.teal,
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height / 8,
          foregroundColor: Colors.teal,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        maxLines: 1,
                        maxLength: 8,
                        validator: (value) {
                          final RegExp startsWith2or3or4 =
                              RegExp(r'^[2-4]\d*$');
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('Phone number is required');
                          }
                          if (!startsWith2or3or4.hasMatch(value)) {
                            return AppLocalizations.of(context)!.translate(
                                'Phone number must start with 2, 3, or 4');
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: AppLocalizations.of(context)!
                              .translate('Enter your phone number'),
                          labelText:
                              AppLocalizations.of(context)!.translate('Phone'),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                      TextFormField(
                        maxLength: 20,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('Password is required');
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: AppLocalizations.of(context)!
                              .translate('Enter your passcode'),
                          labelText: AppLocalizations.of(context)!
                              .translate('Password'),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                          height: MediaQuery.of(context).size.height / 14,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.teal,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                  phoneController.text,
                                  passwordController.text);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.translate('Login'),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.translate('Don\'t have an account ?')} ',
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushNamed(context, '/signup'),
                                text: AppLocalizations.of(context)!
                                    .translate('Create one'),
                                style: const TextStyle(color: Colors.teal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
