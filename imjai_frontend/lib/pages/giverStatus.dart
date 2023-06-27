import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:im_stepper/stepper.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/giverStatusDetail.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';
import 'package:imjai_frontend/widget/orderStatusDetail.dart';

class giverStatus extends StatefulWidget {
  const giverStatus({super.key});

  @override
  State<giverStatus> createState() => _giverStatusState();
}

class _giverStatusState extends State<giverStatus> {
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
                  Stack(
                    children: [
                      giverStatusDetail(),
                    ],
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
