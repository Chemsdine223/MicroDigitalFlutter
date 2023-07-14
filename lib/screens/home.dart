import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:microdigital/screens/profil.dart';
import 'package:microdigital/screens/request.dart';

import '../app_localizations.dart';
import 'home_page.dart';
import 'loan_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [HomePage(), RequestPage(), LoanHistory()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'LoansApp',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Quicksand',
                ),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                );
              }),
              toolbarHeight: MediaQuery.of(context).size.height / 10,
              foregroundColor: Colors.teal,
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            DrawerHeader(
                              child: Image.asset(
                                'Img/user (3).png',
                                width: MediaQuery.of(context).size.width / 2,
                                // height: 2,
                              ),
                            ),
                            Text(
                              state.user.nom,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 14,
                            )
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      onTap: () {
                        print('${state.user.prenom} +++++++++++++');
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ProfilPage(
                                nom: state.user.nom,
                                prenom: state.user.prenom,
                                nni: state.user.nni);
                          },
                        ));
                      },
                      leading: const Icon(Icons.person_outlined),
                      title: Text(
                        'Profil',
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.read<AuthCubit>().logOut();
                        debugPrint('Bye');
                      },
                      leading: const Icon(Icons.logout),
                      title: Text(
                        AppLocalizations.of(context)!.translate('Sign out'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: CurvedNavigationBar(
              // fixedColor: Colors.black,
              // elevation: 0.0,
              backgroundColor: Colors.white,
              color: Colors.teal,
              index: _selectedIndex,
              onTap: navigateBottomBar,
              items: const [
                Icon(
                  color: Colors.white,
                  FluentSystemIcons.ic_fluent_home_filled,
                ),
                Icon(
                  FluentSystemIcons.ic_fluent_briefcase_filled,
                  color: Colors.white,
                ),
                Icon(
                  color: Colors.white,
                  FluentSystemIcons.ic_fluent_clock_filled,
                ),
              ],
            ),
            body: SafeArea(
              bottom: false,
              child: _pages[_selectedIndex],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
