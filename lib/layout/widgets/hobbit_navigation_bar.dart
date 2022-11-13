import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HobbitNavigationBar extends StatelessWidget {
  HobbitNavigationBar({
    super.key,
    this.currentIndex = 0,
    this.changeScreen,
  });
  final int currentIndex;
  void Function(int)? changeScreen;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      elevation: 0,
      currentIndex: currentIndex,
      onTap: changeScreen,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/dashboard_inactive.svg",
            height: 20,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/dashboard_active.svg",
            height: 20,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/bag_inactive.svg",
            height: 20,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/bag_active.svg",
            height: 20,
          ),
          label: "Lock",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/calendar_inactive.svg",
            height: 20,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/calendar_active.svg",
            height: 20,
          ),
          label: "Love",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/profile_inactive.svg",
            height: 20,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/profile_active.svg",
            height: 20,
          ),
          label: "Done",
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
