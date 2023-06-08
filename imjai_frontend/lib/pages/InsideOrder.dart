import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';

class InsideOrder extends StatefulWidget {
  const InsideOrder({super.key});

  @override
  State<InsideOrder> createState() => _InsideOrderState();
}

class _InsideOrderState extends State<InsideOrder> {
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
                    padding: EdgeInsets.only(top: 60),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: [
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
                                ],
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
                  OrderDetail()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
