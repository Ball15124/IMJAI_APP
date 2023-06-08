import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Premium Wagyu A5",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
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
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giver",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("Images/profile.jpg"),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Mrs. Gwen Camiron",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 100),
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
          SizedBox(height: 140),
        ],
      ),
    );
  }
}
