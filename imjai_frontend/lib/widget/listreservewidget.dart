import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/InsideOrder.dart';
import 'package:imjai_frontend/pages/recieverStatus.dart';

import 'package:imjai_frontend/widget/orderDetail.dart';

class ListReserveWidget extends StatefulWidget {
  const ListReserveWidget({super.key});

  @override
  State<ListReserveWidget> createState() => _ListReserveWidgetState();
}

class _ListReserveWidgetState extends State<ListReserveWidget> {
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
          reserveList(
            title: 'Premium Wagyu A5',
            tag: 'Meat',
            imageUrl: 'wagyu',
            owner: 'Peter Parker',
            range: '2.5 km',
          ),
          reserveList(
            title: 'Chinese Cabbage',
            tag: 'Veget&Fruit',
            imageUrl: 'cabbage',
            owner: 'MJ',
            range: '1.3 km',
          ),
          reserveList(
            title: 'Prok Curry',
            tag: 'Food',
            imageUrl: 'curry',
            owner: 'Mctominay',
            range: '0.8 km',
          ),
          reserveList(
            title: 'Kurobuta',
            tag: 'Meat',
            imageUrl: 'kurobuta',
            owner: 'Nawat Sujjaritrat',
            range: '1.8 km',
          ),
          reserveList(
            title: 'Swensen',
            tag: 'Dessert',
            imageUrl: 'swensen',
            owner: 'Panusorn Roeksukrungrueang',
            range: '3.2 km',
          ),
        ],
      ),
    );
  }
}

class reserveList extends StatelessWidget {
  String title;
  String imageUrl;
  String tag;
  String range;
  String owner;

  reserveList(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.tag,
      required this.range,
      required this.owner})
      : super(key: key);

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

    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => recieverStatus())));
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
                    width: 110,
                    height: 110,
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
