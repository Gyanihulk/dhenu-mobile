import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
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
     final localization = AppLocalizations.of(context);
    return BottomNavigationBar(
      backgroundColor: const Color(0XFFEAE5D8),
      currentIndex: currentPageIndex,
      onTap: _onItemTapped,
      items:  [
        BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.house), label: localization?.translate('navigation.home')),
        BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.handHoldingHeart), label: localization?.translate('navigation.donate')),
        BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.user), label: localization?.translate('navigation.profile'))
      ],
      elevation: 20,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.secondaryGrey,
    );
  }
}
