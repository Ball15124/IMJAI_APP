import 'package:dio/dio.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
// import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/model/me.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/location.dart';
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
  List<mainProduct> mainproduct = [];
  String phone_number = '';
  String fname = '';
  String lastname = '';
  String email = '';
  // String faculty = '';
  // String department = '';
  String profileUrl = '';
  String birthdate = '';
  // double screenHeight = 0;
  // double screenWidth = 0;
  // final users = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await Caller.dio.get("/home/me");
      Response productResponse = await Caller.dio.get("/home/list");
      setState(() {
        final data = meProfile.fromJson(response.data);
        fname = data.firstname;
        lastname = data.lastname;
        email = data.email;
        phone_number = data.phone_number;
        birthdate = data.birthdate;
        this.profileUrl = data.profile_url;
        print(data.firstname);

        final List<dynamic> productRes = productResponse.data;
        for (var productResponse in productRes) {
          mainproduct.add(mainProduct.fromJson(productResponse));
        }
        print(mainproduct);
      });
    } catch (e) {
      print(e);
    }
  }

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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Location()));
                          },
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
