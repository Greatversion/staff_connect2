import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  final void Function(int index) onIndexChanged;

  const CustomNavigationBar({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
        child: GNav(
          haptic: true,
          curve: Curves.easeOutExpo,
          rippleColor: const Color(0xFF212B66),
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          duration: const Duration(milliseconds: 100),
          tabBackgroundColor: const Color(0xFFFE9F02),
          color: Colors.black,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.task_alt,
              text: 'Tasks',
            ),
            GButton(
              icon: CupertinoIcons.calendar_badge_plus,
              text: 'Leave Request',
            ),
            GButton(
              icon: CupertinoIcons.profile_circled,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            onIndexChanged(index);

            // Call the callback with the updated index
          },
        ),
      ),
    );
  }
}
