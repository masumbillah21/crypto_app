import 'package:crypto_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _currentIndex = value;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/1.1.png",
                height: height * 0.03,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/1.2.png",
                height: height * 0.03,
                color: const Color(0XFFFBC700),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/2.1.png",
                height: height * 0.03,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/2.2.png",
                height: height * 0.03,
                color: const Color(0XFFFBC700),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/3.1.png",
                height: height * 0.03,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/3.2.png",
                height: height * 0.03,
                color: const Color(0XFFFBC700),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/4.1.png",
                height: height * 0.03,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/4.2.png",
                height: height * 0.03,
                color: const Color(0XFFFBC700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
