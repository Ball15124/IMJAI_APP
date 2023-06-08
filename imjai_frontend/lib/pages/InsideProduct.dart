import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/productDetail.dart';

class InsideProduct extends StatefulWidget {
  const InsideProduct({super.key});

  @override
  State<InsideProduct> createState() => _InsideProductState();
}

class _InsideProductState extends State<InsideProduct> {
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
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop((context));
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        title: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange),
                                        ),
                                        content: const Text(
                                            'Do you want to delete this porduct?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(children: [
                        Container(
                          height: 300,
                          width: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("Images/Food/wagyu.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  ProductDetail(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
