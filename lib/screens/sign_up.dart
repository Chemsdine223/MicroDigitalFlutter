import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/auth/authservices.dart';

import '../app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool status = false;
  bool isLoading = false;
  String? passwordError;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController nNNicontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController password2controller = TextEditingController();

  Future<bool> submit() async {
    setState(() {
      isLoading = true;
    });

    final dynamic response = await AuthService.signUp(
      nNNicontroller.text,
      nomController.text,
      phonecontroller.text,
      prenomController.text,
      password1controller.text,
      password2controller.text,
    );

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Created successfully!')),
      );
      setState(() {
        status = response;
        isLoading = false;
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check the provided data!')),
      );
      setState(() {
        status = response;
        isLoading = false;
      });
    }

    return status;
  }

  String? validatePasswordsMatch(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    nNNicontroller.dispose();
    nomController.dispose();
    phonecontroller.dispose();
    prenomController.dispose();
    password1controller.dispose();
    password2controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
        ),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Sign up',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 30,
                  color: Colors.teal,
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height / 14,
              foregroundColor: Colors.teal,
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMsg)),
                  );
                } else if (state is SignUpSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.success),
                    ),
                  );
                }
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your ID';
                                }
                                return null;
                              },
                              controller: nNNicontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .translate('Enter your ID number'),
                                labelText: AppLocalizations.of(context)!
                                    .translate('ID'),
                                prefixIcon: const Icon(Icons.credit_card),
                              ),
                              maxLength: 10,
                              maxLines: 1,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your last name';
                                }
                                return null;
                              },
                              controller: nomController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                // border: OutlineInputBorder(),
                                hintText: 'Enter your last name',
                                labelText: 'Last name',
                              ),
                              maxLength: 40,
                              maxLines: 1,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your name';
                                }
                                return null;
                              },
                              controller: prenomController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .translate('Enter your name'),
                                labelText: AppLocalizations.of(context)!
                                    .translate('Name'),
                                prefixIcon: const Icon(Icons.person_2_outlined),
                              ),
                              maxLength: 40,
                              maxLines: 1,
                            ),
                            TextFormField(
                              validator: (value) {
                                final RegExp startsWith2or3or4 =
                                    RegExp(r'^[2-4]\d*$');
                                if (value!.isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!startsWith2or3or4.hasMatch(value)) {
                                  return 'Phone number must start with 2, 3, or 4';
                                }
                                return null;
                              },
                              controller: phonecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .translate('Phone number'),
                                labelText: AppLocalizations.of(context)!
                                    .translate('Phone'),
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              maxLength: 8,
                              maxLines: 1,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: password1controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .translate('Enter your password'),
                                labelText: AppLocalizations.of(context)!
                                    .translate('Password'),
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              maxLength: 20,
                              maxLines: 1,
                              onChanged: (value) {
                                setState(() {
                                  passwordError = validatePasswordsMatch(
                                    value,
                                    password2controller.text,
                                  );
                                });
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: password2controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .translate('Confirm your password'),
                                labelText: AppLocalizations.of(context)!
                                    .translate('Confirm Password'),
                                prefixIcon: const Icon(Icons.lock),
                                errorText: passwordError,
                              ),
                              maxLength: 20,
                              maxLines: 1,
                              onChanged: (value) {
                                setState(() {
                                  passwordError = validatePasswordsMatch(
                                    password1controller.text,
                                    value,
                                  );
                                });
                              },
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: MaterialButton(
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    minWidth: MediaQuery.of(context).size.width,
                                    color: Colors.teal,
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              bool success = await submit();
                                              if (success) {
                                                context
                                                    .read<AuthCubit>()
                                                    .signIn();
                                              }
                                            }
                                          },
                                    child: isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .translate('Sign up'),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
