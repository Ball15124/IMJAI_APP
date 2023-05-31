import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/categorieswidget.dart';
import 'package:imjai_frontend/widget/listorderwidget.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/searchwidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Welcome 👋🏻",
                                  style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Gwen Camiron",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Profile()));
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage("Images/profile.jpg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 45),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.orange,
                            minimumSize: Size(screenWidth - 30, 50),
                          ),
                          icon: const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          label: const Text(
                            'Current Location',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(height: screenHeight / 65),
                        SearchWidget(),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        CategoriesWidget(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "List",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        ListOrderWidget(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
