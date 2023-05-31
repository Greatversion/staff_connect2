import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  final void Function(int index) onIndexChanged;

  const CustomNavigationBar({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return GNav(
      backgroundColor: const Color(0xFF212B66),
      haptic: true,
      curve: Curves.easeOutExpo,
      rippleColor: const Color(0xFF212B66),
      hoverColor: Colors.grey[100]!,
      gap: 8,
      activeColor: Colors.black,
      iconSize: 25,
      padding: const EdgeInsets.all(14),
      duration: const Duration(milliseconds: 100),
      tabBackgroundColor: const Color(0xFFFE9F02),
      color: Colors.white,
      tabs: [
        GButton(
          textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold),
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold),
          icon: Icons.task_alt,
          text: 'Tasks',
        ),
        GButton(
          textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold),
          icon: CupertinoIcons.calendar_badge_plus,
          text: 'Leave Request',
        ),
        GButton(
          textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold),
          icon: CupertinoIcons.profile_circled,
          text: 'Profile',
        ),
      ],
      selectedIndex: _selectedIndex,
      onTabChange: (index) {
        onIndexChanged(index);

        // Call the callback with the updated index
      },
    );
  }
}
