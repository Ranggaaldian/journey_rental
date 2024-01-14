import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatefulWidget {
  final int activeIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  final navbarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_today,
      ),
      label: 'History',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navbarItems,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      currentIndex: widget.activeIndex,
      onTap: widget.onTap,
    );
  }
}
