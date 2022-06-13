import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SearchPage(),
    const SettingsPage(),
  ];

  void _obBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            // Home
            BottomNavigationBarItem(
              icon: Icon(
                  Platform.isIOS ? CupertinoIcons.home : Icons.home_outlined),
              activeIcon:
                  Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
              label: AppLocalizations.of(context)!.listPage_home,
            ),
            // Favorite
            BottomNavigationBarItem(
              icon: Icon(
                  Platform.isIOS ? CupertinoIcons.star : Icons.favorite_border),
              activeIcon: Icon(
                  Platform.isIOS ? CupertinoIcons.star_fill : Icons.favorite),
              label: AppLocalizations.of(context)!.favoritePage_title,
            ),
            // Search
            BottomNavigationBarItem(
              icon: Icon(Platform.isIOS
                  ? CupertinoIcons.search
                  : Icons.search_outlined),
              activeIcon:
                  Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
              label: AppLocalizations.of(context)!.searchPage_title,
            ),
            // Settings
            BottomNavigationBarItem(
              icon: Icon(Platform.isIOS
                  ? CupertinoIcons.settings
                  : Icons.settings_outlined),
              activeIcon: Icon(
                  Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
              label: AppLocalizations.of(context)!.settingsPage_title,
            ),
          ],
          currentIndex: _bottomNavIndex,
          onTap: _obBottomNavTapped,
        ),
      ),
    );
  }
}
