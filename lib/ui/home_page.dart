import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/search_page.dart';

/// [HomePage] is the main of app container that contains widget
/// [BottomNavigationBar], which follow user to what they're want.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const SearchPage(),
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
              BottomNavigationBarItem(
                icon: Icon(
                    Platform.isIOS ? CupertinoIcons.home : Icons.home_outlined),
                activeIcon:
                Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
                label: AppLocalizations.of(context)!.listPage_home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Platform.isIOS
                    ? CupertinoIcons.search
                    : Icons.search_outlined),
                activeIcon:
                Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
                label: AppLocalizations.of(context)!.searchPage_title,
              ),
            ],
            currentIndex: _bottomNavIndex,
            onTap: _obBottomNavTapped,
          ),
        ),
    );
  }

}
