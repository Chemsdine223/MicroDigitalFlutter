import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:microdigital/app_localizations.dart';

import '../auth/authservices.dart';
import '../components/text_field.dart';

class ProfilPage extends StatefulWidget {
  final String nom;
  final String prenom;
  final String nni;
  const ProfilPage({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.nni,
  }) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isLoading = false; // Track loading state

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final url =
        'https://pubgmobilemmj.pythonanywhere.com/users/changepasswordd/';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.accessToken}',
      },
      body: jsonEncode(
        {
          "old_password": oldPassword,
          "new_password": newPassword,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response);
      return true;
    } else {
      return false;
    }
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset(
                  'Img/profile.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              Center(
                child: Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'QuickSand',
                  ),
                ),
              ),
              Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('First name'),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.nom,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('Last name'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                              Text(
                                widget.prenom,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate('ID'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                              Text(
                                widget.nni.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate(
                                                    'Change your password'),
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomTextField(
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'hi';
                                                    } else {
                                                      return '';
                                                    }
                                                  },
                                                  controller: oldPassword,
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'Enter your old password'),
                                                  label: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'Old password'),
                                                  icon: Icon(Icons.lock),
                                                  maxLength: 20,
                                                  maxLines: 1,
                                                  hideText: true,
                                                ),
                                                SizedBox(height: 20),
                                                CustomTextField(
                                                  controller: newPassword,
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'Enter your new password'),
                                                  label: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'New password'),
                                                  icon: Icon(Icons.lock),
                                                  maxLength: 20,
                                                  maxLines: 1,
                                                  hideText: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30),
                                            child: Stack(
                                              children: [
                                                MaterialButton(
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      16,
                                                  color: Colors.teal,
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoading =
                                                          true; // Set loading state to true
                                                    });

                                                    final res =
                                                        await changePassword(
                                                      oldPassword.text,
                                                      newPassword.text,
                                                    );

                                                    if (res) {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .translate(
                                                                      'Changed successfully')),
                                                        ),
                                                      );
                                                    } else {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .translate(
                                                                    'An error occurred'),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    setState(() {
                                                      isLoading =
                                                          false; // Set loading state to false
                                                    });
                                                  },
                                                  child: Text(
                                                    'Change',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                if (isLoading)
                                                  Positioned.fill(
                                                    child: Container(
                                                      color: Colors.teal,
                                                      // .withOpacity(0.5),
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 12,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('Change your password'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
