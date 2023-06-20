import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';

class OrderStatusDetail extends StatefulWidget {
  const OrderStatusDetail({super.key});

  @override
  State<OrderStatusDetail> createState() => _OrderStatusDetailState();
}

class _OrderStatusDetailState extends State<OrderStatusDetail> {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      Text(
                        "Waiting giver to confirm",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 23),
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
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
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
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 17),
                      ),
                      Text(
                        ". . .",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("Images/profile.jpg"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0),
                    child: Row(
                      children: [
                        Text(
                          "Mr. Gwen Camiron",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.phone,
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '1 items',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red, width: 2),
              minimumSize: const Size(double.infinity, 50),
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
                    content: const Text('Do you want to cancel this product?'),
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
                        onPressed: () {},
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
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
