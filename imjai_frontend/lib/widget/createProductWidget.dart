import 'dart:core';
import 'dart:ui';
import 'package:fluttertagselector/fluttertagselector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertagselector/tag_class.dart';
import 'package:imjai_frontend/widget/chiptag.dart';

import 'listorderwidget.dart';

class CreateProductWidget extends StatefulWidget {
  const CreateProductWidget({super.key});

  @override
  State<CreateProductWidget> createState() => _CreateProductWidgetState();
}

class _CreateProductWidgetState extends State<CreateProductWidget> {
  TextEditingController proname = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController time = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
            ),
            SizedBox(height: screenHeight / 35),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Product Name", proname),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Description", description),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Available Time", time),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            ChipTag(),
            SizedBox(height: screenHeight / 85),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            Container(
              height: 100,
              width: screenWidth - 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
            ),
            SizedBox(height: screenHeight / 60),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller) {
    return Container(
      width: screenWidth - 35,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 237, 239),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey,
            //   spreadRadius: 2,
            //   blurRadius: 5,
            //   offset: Offset(5, 7),
            // )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight / 40,
                    ),
                    hintText: hint,
                    border: InputBorder.none),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
