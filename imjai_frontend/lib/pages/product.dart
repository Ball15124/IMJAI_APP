import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/createproduct.dart';
import 'package:imjai_frontend/widget/listproductwidget.dart';

import '../widget/listorderwidget.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
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
                        Center(
                          child: Text(
                            "My Product",
                            style: TextStyle(
                                fontSize: screenWidth / 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: screenHeight / 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Product List",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 20),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Createproduct()));
                              },
                              icon: const Icon(
                                Icons.add_circle_rounded,
                                size: 35,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 65),
                        ListProductWidget(),
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
