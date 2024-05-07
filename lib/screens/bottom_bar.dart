import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/dark_theme_provider.dart';
import 'package:flutter_application_1/screens/categories.screen.dart';
import 'package:flutter_application_1/screens/home.screen.dart';
import 'package:flutter_application_1/screens/profile.screen.dart';
import 'package:flutter_application_1/screens/cart/shopping_cart.screen.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 2;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': CategoriesScreen(), 'title': 'Categories Screen'},
    {'page': const ShoppingCartScreen(), 'title': 'Shopping Cart Screen'},
    {'page': const ProfileScreen(), 'title': 'Profile  Screen'}
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories"),
          BottomNavigationBarItem(
              icon: badges.Badge(
                badgeContent: FittedBox(
                    child: TextWidget(
                        text: '1', color: Colors.white, textSize: 15)),
                position: badges.BadgePosition.topEnd(top: -15, end: -10),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  elevation: 0,
                ),
                child: Icon(
                    _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              ),
              label: "Shoppping Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: "Profile")
        ],
      ),
    );
  }
}
