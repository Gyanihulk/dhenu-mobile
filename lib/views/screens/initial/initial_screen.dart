import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/donate/donate_screen.dart';
import 'package:dhenu_dharma/views/screens/notification/notification_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/profile_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/language/languages_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/home_screen.dart';

class InitialScreen extends StatefulWidget {
  final int pageIndex;
  const InitialScreen({super.key, required this.pageIndex});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const DonateScreen(),
    const ProfileScreen(),

    const NotificationsScreen(), //
  ];

  @override
  void initState() {
    _selectedIndex = widget.pageIndex;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0XFFEAE5D8),
        currentIndex: _selectedIndex>2?2:_selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.house),
              label: localization?.translate('navigation.home')),
          BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.handHoldingHeart),
              label: localization?.translate('navigation.donate')),
          BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.solidUser),
              label: localization?.translate('navigation.profile')),
          // BottomNavigationBarItem(
          //   icon: const FaIcon(
          //     FontAwesomeIcons.solidBell,
          //     key: Key('notificationIcon'), // Add a unique key
          //   ),
          //   label: localization?.translate('navigation.notifications'),
          // ),
        ],
        elevation: 20,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.secondaryGrey,
      ),
    );
  }
}
