import 'package:flutter/material.dart';
import 'package:imjai_frontend/pages/home.dart';
import 'package:imjai_frontend/pages/product.dart';
import 'package:imjai_frontend/pages/reserve.dart';

class NavigationbarWidget extends StatefulWidget {
  const NavigationbarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationbarWidget> createState() => _NavigationbarWidgetState();
}

class _NavigationbarWidgetState extends State<NavigationbarWidget> {
  final pages = const [Product(), Home(), Reserve()];
  List<String> data2 = ["Product", "Home", "Reserve"];

  int _currentIndex = 1;
  double screenHeight = 0;
  double screenWidth = 0;

  final List<BottomNavigationBarItem> _navigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Product',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Reserve',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navigationItems,
        selectedItemColor: Colors.orange,
      ),
    );
  }
}
