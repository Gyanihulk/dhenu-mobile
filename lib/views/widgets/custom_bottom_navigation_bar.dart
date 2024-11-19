import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  int pageIndex;
  CustomBottomNavigationBar({super.key, required this.pageIndex});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  void initState() {
    currentPageIndex = widget.pageIndex;
    super.initState();
  }

  void _onItemTapped(int pageIndex) {
    CustomNavigator(
            context: context, screen: InitialScreen(pageIndex: pageIndex))
        .pushAndRemoveUntil();
    currentPageIndex = pageIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0XFFEAE5D8),
      currentIndex: currentPageIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.handHoldingHeart), label: "Donate"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user), label: "Profile")
      ],
      elevation: 20,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.secondaryGrey,
    );
  }
}
