import 'package:flutter/material.dart';
import 'package:journeyrental/ui/pages/history_page.dart';
import 'package:journeyrental/ui/pages/home_page.dart';
import 'package:journeyrental/ui/pages/profil_page.dart';
import 'package:journeyrental/ui/widgets/custom_bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: activeIndex);
    pageController.addListener(() {
      setState(() {
        activeIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    setState(() {
      activeIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          const HomePage(),
          HistoryPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavbar(
        activeIndex: activeIndex,
        onTap: onTap,
      ),
    );
  }
}

