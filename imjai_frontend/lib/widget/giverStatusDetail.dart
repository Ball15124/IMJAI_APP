import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:im_stepper/stepper.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';

class giverStatusDetail extends StatefulWidget {
  const giverStatusDetail({super.key});

  @override
  State<giverStatusDetail> createState() => _giverStatusDetailState();
}

class _giverStatusDetailState extends State<giverStatusDetail> {
  double screenHeight = 0;
  double screenWidth = 0;
  int activeStep = 0; // Initial step set to 5.
  bool isPass = false;
  final dotCount = [0, 1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 5,
                        color: Colors.orange,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: activeStep >= 1 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color:
                                activeStep >= 1 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 65,
                        height: 5,
                        color: activeStep >= 1 ? Colors.orange : Colors.grey,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: activeStep >= 2 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color:
                                activeStep >= 2 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 5,
                        color: activeStep >= 2 ? Colors.orange : Colors.grey,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: activeStep >= 3 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color:
                                activeStep >= 3 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Text(
                        "Waiting",
                        style: TextStyle(
                            color:
                                activeStep >= 0 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 42,
                      ),
                      Text(
                        "Preparing",
                        style: TextStyle(
                            color:
                                activeStep >= 1 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 43,
                      ),
                      Text(
                        "Ready",
                        style: TextStyle(
                            color:
                                activeStep >= 2 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      Text(
                        "Complete",
                        style: TextStyle(
                            color:
                                activeStep >= 3 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order# XXXXXXXX",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          Text(
                            (activeStep == 0)
                                ? "Waiting you to confirm"
                                : (activeStep == 1)
                                    ? "Order Preparing"
                                    : (activeStep == 2)
                                        ? "We have received your order"
                                        : "Complete",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            "Time",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "King Mongkut's institute of\ntechnology Thonburi",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          ),
                          Text(
                            "16:00 - 19:00",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("Images/profile.jpg"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            Text(
                              "Mr. Gwen Camiron",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order Details",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          )
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wagyu for sukiyaki 350 g.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "Categories",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "Range",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "16.00",
                              textAlign: TextAlign.center,
                            ),
                            Text("Meat", textAlign: TextAlign.center),
                            Text("2.5 km", textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '1 items',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      side: const BorderSide(color: Colors.orange, width: 2),
                      minimumSize: const Size(150, 60),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            title: Text(
                              'Warning',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            content: const Text(
                                'Do you want to cancel this product?'),
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
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.orange),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.orange,
                          side: BorderSide(color: Colors.orange, width: 2),
                          minimumSize: Size(150, 60)),
                      onPressed: () {
                        if (activeStep == 3) {
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                content: const Text(
                                    'Do you want to confirm this product?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.red,
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
                                    onPressed: () {
                                      if (activeStep <= 3) {
                                        setState(() {
                                          activeStep++;
                                          Navigator.pop(context);
                                        });
                                      }
                                      if (activeStep > 3) {
                                        setState(() {
                                          activeStep = 3;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              title: Text(
                                                '',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'You have reach the process !'),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    side: BorderSide(
                                                      color: Colors.orange,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      print(activeStep);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        activeStep == 3 ? 'Complete' : "Confirm",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
