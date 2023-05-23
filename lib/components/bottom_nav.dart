import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  final void Function(int)? onTabChange;
  const BottomNav({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      onTabChange: (value) => onTabChange!(value),
      color: Colors.white,
      mainAxisAlignment: MainAxisAlignment.center,
      // activeColor: Colors.blueGrey[100],
      // tabBackgroundColor: Colors.grey,
      // tabBorderRadius: 24,
      // tabActiveBorder: Border.all(color: Colors.white),
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: Icons.send_outlined,
          text: 'Request',
        ),
      ],
    );
  }
}
