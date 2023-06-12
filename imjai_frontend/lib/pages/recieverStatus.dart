import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';
import 'package:imjai_frontend/widget/orderStatusDetail.dart';

class recieverStatus extends StatefulWidget {
  const recieverStatus({super.key});

  @override
  State<recieverStatus> createState() => _recieverStatusState();
}

class _recieverStatusState extends State<recieverStatus> {
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
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(children: [
                          Container(
                            height: 400,
                            width: 600,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "Images/ReserveStatus/OrderTrackingImage.gif"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ]),
                      ),
                      Positioned(
                        top: 40,
                        left: 5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop((context));
                            Navigator.pop((context));
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 35,
                            color: Color.fromARGB(255, 250, 122, 48),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 350),
                          child: OrderStatusDetail())
                    ],
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
