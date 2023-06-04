import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/createProductwidget.dart';

class Createproduct extends StatefulWidget {
  const Createproduct({super.key});

  @override
  State<Createproduct> createState() => _CreateproductState();
}

class _CreateproductState extends State<Createproduct> {
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
                    padding: EdgeInsets.only(top: 60, left: 10),
                    color: primary,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 4),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop((context));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 70),
                            child: Text(
                              "Product",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight / 35),
                      ],
                    ),
                  ),
                  CreateProductWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
