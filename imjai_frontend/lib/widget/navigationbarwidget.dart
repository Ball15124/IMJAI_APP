import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/home.dart';

class NavigationbarWidget extends StatefulWidget {
  const NavigationbarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationbarWidget> createState() => _NavigationbarWidgetState();
}

class _NavigationbarWidgetState extends State<NavigationbarWidget> {
  final pages = const [Home()];
  int _selectedTab = 0;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: ((index) {
          setState(() {
            this._selectedTab = index;
          });
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_rounded,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.format_list_bulleted_rounded,
            ),
            label: 'Reserve',
          ),
        ],
        backgroundColor: Colors.orange[50],
        selectedItemColor: Colors.orange,
      ),
      body: pages[_selectedTab],
    );
  }
}
