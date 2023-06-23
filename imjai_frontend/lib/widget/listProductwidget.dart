import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/InsideProduct.dart';

import '../pages/InsideOrder.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      child: Column(
        children: <Widget>[
          ProductList(
            id: 1,
            title: 'Premium Wagyu A5',
            tag: 'Meat',
            imageUrl: 'wagyu',
            owner: 'Peter Parker',
            range: '2.5 km',
            status: 'Complete',
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  int id;
  String title;
  String imageUrl;
  String tag;
  String range;
  String owner;
  String status;

  ProductList({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.tag,
    required this.range,
    required this.owner,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.tag == "1") {
      tag = "Meat";
    } else if (this.tag == "2") {
      // Handle other cases if needed
      tag = "Vegetable & Fruit";
    } else if (this.tag == "3") {
      // Handle other cases if needed
      tag = "Food";
    } else if (this.tag == "4") {
      // Handle other cases if needed
      tag = "Flavoring";
    } else if (this.tag == "5") {
      // Handle other cases if needed
      tag = "Drink";
    } else if (this.tag == "6") {
      // Handle other cases if needed
      tag = "Snack";
    } else if (this.tag == "7") {
      // Handle other cases if needed
      tag = "Dessert";
    } else if (this.tag == "8") {
      // Handle other cases if needed
      tag = "Food Waste";
    } else {
      tag = "No Categories";
    }

    if (this.status == "0") {
      status = "Not reserved yet";
    } else if (this.status == "1") {
      // Handle other cases if needed
      status = "Waiting to confirm";
    } else if (this.status == "2") {
      // Handle other cases if needed
      status = "Preparing Order";
    } else if (this.status == "3") {
      // Handle other cases if needed
      status = "Waiting for pick-up";
    } else if (this.status == "4") {
      // Handle other cases if needed
      status = "Completed";
    }

    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InsideProduct(),
                  settings: RouteSettings(
                    arguments: id,
                  )));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(4, 5),
            )
          ]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the border radius
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Container(
                    width: 130,
                    height: 130,
                    child: Image.asset(
                      'Images/Food/' + imageUrl + ".jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          tag,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          range,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          owner,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          status,
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
