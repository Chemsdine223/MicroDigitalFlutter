import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
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

  final List<Widget> _pages = const [
    HomePage(),
    RequestPage(),
    // LoadingScreen()
    LoanHistory()
  ];

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
                        context.read<AuthCubit>().logOut();
                        debugPrint('Bye');
                      },
                      leading: const Icon(Icons.logout),
                      title: Text(
                        AppLocalizations.of(context)!.translate('Sign out'),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.black,
              elevation: 0.0,
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: navigateBottomBar,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(FluentSystemIcons.ic_fluent_home_filled),
                    label: AppLocalizations.of(context)!.translate('Home')),
                BottomNavigationBarItem(
                    icon: const Icon(
                      FluentSystemIcons.ic_fluent_briefcase_filled,
                    ),
                    label: AppLocalizations.of(context)!
                        .translate('Request a loan')),
                BottomNavigationBarItem(
                    icon: const Icon(
                      FluentSystemIcons.ic_fluent_clock_filled,
                    ),
                    label: AppLocalizations.of(context)!
                        .translate('Loan history')),
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

// import 'package:flutter/material.dart';

// import '../auth/authservices.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: HomeLayout(),
//         ),
//       ),
//     );
//   }
// }

// class HomeLayout extends StatelessWidget {
//   HomeLayout({
//     super.key,
//   });

//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             'Img/dollar.png',
//             height: 70,
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           Text(
//             'Hi, Welcome Back !',
//             style: TextStyle(
//               fontSize: 34,
//               fontWeight: FontWeight.bold,
//               color: Colors.blueGrey[900],
//               // textAlign: Alignment.center,
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           const Text(
//             'Numéro du téléphone :',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(
//             height: 28,
//           ),
//           TextField(
//             controller: _phoneController,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 28,
//           ),
//           const Text(
//             'Mot de passe :',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(
//             height: 28,
//           ),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 28,
//           ),
//           const Text('Mot de passe oublié ?'),
//           const SizedBox(
//             height: 28,
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: GestureDetector(
//               onTap: () {
//                 AuthService.login(
//                   _phoneController.text,
//                   _passwordController.text,
//                 );
//                 // debugdebugPrint('Hi there !');
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue[800],
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(20),
//                   ),
//                 ),
//                 height: 100,
//                 width: 400,
//                 child: const Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'CONNEXION',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           RichText(
//             text: TextSpan(children: [
//               const TextSpan(
//                 text: 'Vous n\'avez pas de compte ? ',
//                 style: TextStyle(color: Colors.black),
//               ),
//               TextSpan(
//                 text: 'Creer un compte',
//                 style: TextStyle(color: Colors.blue[700]),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
