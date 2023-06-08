import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/categorieswidget.dart';
import 'package:imjai_frontend/widget/listreservewidget.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/searchwidget.dart';

class Reserve extends StatefulWidget {
  const Reserve({super.key});

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
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
                        Center(
                          child: Text(
                            "My Reserve",
                            style: TextStyle(
                                fontSize: screenWidth / 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: screenHeight / 45),
                        Row(
                          children: [
                            Text(
                              "My Reserve List",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 20),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 65),
                        ListReserveWidget(),
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
