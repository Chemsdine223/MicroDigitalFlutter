// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/auth/authservices.dart';

import '../app_localizations.dart';
import '../components/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool status = false;

  Future<bool> submit() async {
    final dynamic response = await AuthService.signUp(
        nNNicontroller.text,
        nomController.text,
        phonecontroller.text,
        prenomController.text,
        password1controller.text,
        password2controller.text);

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Created successfully !')));
      setState(() {
        status = response;
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check the provided data !')));
      setState(() {
        status = response;
      });
    }
    return status;
  }

  final _formKey = GlobalKey<FormState>();
  String imagePath = '';
  XFile? image;
  // File?(imagePath);
  final picker = ImagePicker();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController nNNicontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController password2controller = TextEditingController();
  String validatePasswordsMatch(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return 'Passwords must match';
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
              // automaticallyImplyLeading: false,
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                } else if (state is SignUpSuccess) {
                  // setState(() {});
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.success),
                  ));
                }
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // GestureDetector(
                            //   onDoubleTap: () {},
                            // ),
                            CustomTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your ID';
                                }
                                return '';
                              },
                              hideText: false,
                              controller: nNNicontroller,
                              hintText: AppLocalizations.of(context)!
                                  .translate('Enter your ID number'),
                              label:
                                  AppLocalizations.of(context)!.translate('ID'),
                              icon: const Icon(Icons.credit_card),
                              maxLength: 10,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter a value';
                                }
                                return '';
                              },
                              hideText: false,
                              controller: nomController,
                              hintText: 'Enter your last name',
                              label: 'Last name',
                              icon: const Icon(Icons.person_2_outlined),
                              maxLength: 40,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your name';
                                }
                                return '';
                              },
                              hideText: false,
                              controller: prenomController,
                              hintText: AppLocalizations.of(context)!
                                  .translate('Enter your name'),
                              label: AppLocalizations.of(context)!
                                  .translate('Name'),
                              icon: const Icon(Icons.person_2_outlined),
                              maxLength: 40,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              validate: (value) {
                                final RegExp startsWith2or3or4 =
                                    RegExp(r'^[2-4]\d*$');
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!startsWith2or3or4.hasMatch(value)) {
                                  return 'Phone number must start with 2, 3, or 4';
                                }
                                return '';
                              },
                              hideText: false,
                              controller: phonecontroller,
                              hintText: AppLocalizations.of(context)!
                                  .translate('Phone number'),
                              label: AppLocalizations.of(context)!
                                  .translate('Phone'),
                              icon: const Icon(Icons.phone),
                              maxLength: 8,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              hideText: true,
                              controller: password1controller,
                              hintText: AppLocalizations.of(context)!
                                  .translate('Enter your password'),
                              label: AppLocalizations.of(context)!
                                  .translate('Password'),
                              icon: const Icon(Icons.lock_outline),
                              maxLength: 20,
                              maxLines: 1,
                              // validate: (value) => validatePasswordsMatch(
                              //     value, password1controller.text),
                            ),
                            CustomTextField(
                              hideText: true,
                              controller: password2controller,
                              hintText: AppLocalizations.of(context)!
                                  .translate('Confirm your password'),
                              label: AppLocalizations.of(context)!
                                  .translate('Confirm Password'),
                              icon: const Icon(Icons.lock),
                              maxLength: 20,
                              maxLines: 1,
                              // validate: (value) => validatePasswordsMatch(
                              //     password2controller.text, value),
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                // return Builder(
                                // builder: (context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: MaterialButton(
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    minWidth: MediaQuery.of(context).size.width,
                                    color: Colors.teal,
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        // submit();
                                        // print('object');
                                        context.read<AuthCubit>().signUp(
                                              phonecontroller.text,
                                              nNNicontroller.text,
                                              password1controller.text,
                                              password2controller.text,
                                              nomController.text,
                                              prenomController.text,
                                            );
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('Sign up'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                // },
                                // );
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
