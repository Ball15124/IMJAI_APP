import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/home.dart';
import 'package:imjai_frontend/pages/order.dart';
import 'package:imjai_frontend/pages/reserve.dart';

class NavigationbarWidget extends StatefulWidget {
  const NavigationbarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationbarWidget> createState() => _NavigationbarWidgetState();
}

class _NavigationbarWidgetState extends State<NavigationbarWidget> {
  final pages = const [Order(), Home(), Reserve()];
  List<IconData> data = [
    Icons.history_rounded,
    Icons.home_rounded,
    Icons.format_list_bulleted_rounded,
  ];
  List<String> data2 = ["Product", "Home", "Reserve"];
  int _selectedTab = 1;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 255, 236, 207),
          child: Container(
            height: 70,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 51),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = i;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: 40,
                    decoration: BoxDecoration(
                      border: i == _selectedTab
                          ? Border(
                              top: BorderSide(
                                  width: 3.0,
                                  color: Color.fromARGB(255, 255, 136, 0)))
                          : null,
                      gradient: i == _selectedTab
                          ? LinearGradient(
                              colors: [
                                  Color.fromARGB(255, 255, 236, 207),
                                  Color.fromARGB(255, 255, 236, 207)
                                ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)
                          : null,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 13,
                        ),
                        Icon(
                          data[i],
                          size: 35,
                          color: i == _selectedTab
                              ? Color.fromARGB(255, 255, 136, 0)
                              : Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Text(
                          data2[i],
                          style: TextStyle(
                            fontSize: 11,
                            color: i == _selectedTab
                                ? Color.fromARGB(255, 255, 136, 0)
                                : Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
      body: pages[_selectedTab],
    );
  }
}
